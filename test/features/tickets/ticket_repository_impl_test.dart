import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/tickets/data/datasources/ticket_remote_datasource.dart';
import 'package:itam_app/features/tickets/data/models/ticket_model.dart';
import 'package:itam_app/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class MockTicketRemoteDataSource extends Mock
    implements TicketRemoteDataSource {}

void main() {
  late MockTicketRemoteDataSource datasource;
  late TicketRepositoryImpl repository;

  setUp(() {
    datasource = MockTicketRemoteDataSource();
    repository = TicketRepositoryImpl(datasource);
  });

  TicketModel modelWith({
    int id = 12,
    String status = 'OPEN',
    Map<String, dynamic>? assignee,
  }) => TicketModel.fromJson({
    'id': id,
    'reference': 'TKT-2026-000$id',
    'type': 'INCIDENT',
    'status': status,
    'priority': 'HIGH',
    'title': 'Ecran hors service',
    'createdAt': '2026-03-14T09:30:00.000Z',
    'updatedAt': '2026-03-14T09:30:00.000Z',
    'requester': {'id': 3, 'firstName': 'Claire', 'lastName': 'Martin'},
    'assignee': assignee,
    'comments': <dynamic>[],
  });

  group('getTickets', () {
    test('delegue au datasource et convertit les modeles en entites', () async {
      when(
        () => datasource.getTickets(),
      ).thenAnswer((_) async => [modelWith(id: 12), modelWith(id: 13)]);

      final result = await repository.getTickets();

      expect(result, isA<List<Ticket>>());
      expect(result, hasLength(2));
      expect(result.first.id, 12);
      expect(result.first.status, TicketStatus.open);
      verify(() => datasource.getTickets()).called(1);
    });

    test(
      'retourne une liste vide quand le datasource ne renvoie rien',
      () async {
        when(() => datasource.getTickets()).thenAnswer((_) async => []);

        final result = await repository.getTickets();

        expect(result, isEmpty);
      },
    );

    test('propage l exception levee par le datasource', () async {
      when(() => datasource.getTickets()).thenThrow(Exception('Erreur reseau'));

      expect(() => repository.getTickets(), throwsA(isA<Exception>()));
    });
  });

  group('getTicketById', () {
    test('transmet l identifiant et convertit le modele', () async {
      when(
        () => datasource.getTicketById(12),
      ).thenAnswer((_) async => modelWith(id: 12));

      final result = await repository.getTicketById(12);

      expect(result, isA<Ticket>());
      expect(result.id, 12);
      verify(() => datasource.getTicketById(12)).called(1);
    });

    test('propage l exception quand le ticket est introuvable', () async {
      when(
        () => datasource.getTicketById(999),
      ).thenThrow(Exception('Ticket non trouve'));

      expect(() => repository.getTicketById(999), throwsA(isA<Exception>()));
    });
  });

  group('createTicket', () {
    final body = {
      'title': 'Ecran hors service',
      'description': 'Aucun affichage',
      'assetId': 21,
    };

    test('transmet le corps de la requete et convertit le modele', () async {
      when(
        () => datasource.createTicket(body),
      ).thenAnswer((_) async => modelWith(id: 12));

      final result = await repository.createTicket(body);

      expect(result, isA<Ticket>());
      expect(result.id, 12);
      verify(() => datasource.createTicket(body)).called(1);
    });

    test('propage l exception en cas de refus du serveur', () async {
      when(
        () => datasource.createTicket(body),
      ).thenThrow(Exception('Requete invalide'));

      expect(() => repository.createTicket(body), throwsA(isA<Exception>()));
    });
  });

  group('updateTicketStatus', () {
    test('transmet le nouveau statut et convertit le modele', () async {
      when(
        () => datasource.updateTicketStatus(12, 'RESOLVED'),
      ).thenAnswer((_) async => modelWith(id: 12, status: 'RESOLVED'));

      final result = await repository.updateTicketStatus(12, 'RESOLVED');

      expect(result.status, TicketStatus.resolved);
      verify(() => datasource.updateTicketStatus(12, 'RESOLVED')).called(1);
    });

    test('propage l exception en cas de transition refusee', () async {
      when(
        () => datasource.updateTicketStatus(12, 'RESOLVED'),
      ).thenThrow(Exception('Transition interdite'));

      expect(
        () => repository.updateTicketStatus(12, 'RESOLVED'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('assignTechnician', () {
    test('transmet le technicien assigne', () async {
      when(() => datasource.assignTechnician(12, 7)).thenAnswer(
        (_) async => modelWith(
          id: 12,
          assignee: {'id': 7, 'firstName': 'Paul', 'lastName': 'Durand'},
        ),
      );

      final result = await repository.assignTechnician(12, 7);

      expect(result.assignee, isNotNull);
      expect(result.assignee!.id, 7);
      verify(() => datasource.assignTechnician(12, 7)).called(1);
    });

    test('accepte un technicien nul pour desassigner le ticket', () async {
      when(
        () => datasource.assignTechnician(12, null),
      ).thenAnswer((_) async => modelWith(id: 12));

      final result = await repository.assignTechnician(12, null);

      expect(result.assignee, isNull);
      verify(() => datasource.assignTechnician(12, null)).called(1);
    });
  });

  group('addComment', () {
    test('transmet le commentaire au datasource', () async {
      when(
        () => datasource.addComment(12, 'Prise en charge'),
      ).thenAnswer((_) async {});

      await repository.addComment(12, 'Prise en charge');

      verify(() => datasource.addComment(12, 'Prise en charge')).called(1);
    });

    test('propage l exception levee par le datasource', () async {
      when(
        () => datasource.addComment(12, 'Prise en charge'),
      ).thenThrow(Exception('Commentaire refuse'));

      expect(
        () => repository.addComment(12, 'Prise en charge'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
