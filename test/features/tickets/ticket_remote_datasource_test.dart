import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/tickets/data/datasources/ticket_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late TicketRemoteDataSourceImpl datasource;

  setUp(() {
    dio = MockDio();
    datasource = TicketRemoteDataSourceImpl(dio);
  });

  Map<String, dynamic> ticketJson({int id = 12, String status = 'OPEN'}) => {
    'id': id,
    'reference': 'TKT-2026-000$id',
    'type': 'INCIDENT',
    'status': status,
    'priority': 'HIGH',
    'title': 'Ecran hors service',
    'createdAt': '2026-03-14T09:30:00.000Z',
    'updatedAt': '2026-03-14T09:30:00.000Z',
    'requester': {'id': 3, 'firstName': 'Claire', 'lastName': 'Martin'},
    'comments': <dynamic>[],
  };

  Response<dynamic> responseWith(dynamic data, String path) =>
      Response<dynamic>(
        requestOptions: RequestOptions(path: path),
        data: data,
        statusCode: 200,
      );

  group('getTickets', () {
    test('appelle la route liste et deserialise la reponse', () async {
      when(() => dio.get('/tickets')).thenAnswer(
        (_) async =>
            responseWith([ticketJson(id: 12), ticketJson(id: 13)], '/tickets'),
      );

      final result = await datasource.getTickets();

      expect(result, hasLength(2));
      expect(result.first.id, 12);
      verify(() => dio.get('/tickets')).called(1);
    });

    test('retourne une liste vide quand la reponse est vide', () async {
      when(
        () => dio.get('/tickets'),
      ).thenAnswer((_) async => responseWith(<dynamic>[], '/tickets'));

      expect(await datasource.getTickets(), isEmpty);
    });

    test('propage l erreur reseau', () async {
      when(() => dio.get('/tickets')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tickets'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(() => datasource.getTickets(), throwsA(isA<DioException>()));
    });
  });

  group('getTicketById', () {
    test('construit la route avec l identifiant', () async {
      when(
        () => dio.get('/tickets/12'),
      ).thenAnswer((_) async => responseWith(ticketJson(), '/tickets/12'));

      final result = await datasource.getTicketById(12);

      expect(result.id, 12);
      verify(() => dio.get('/tickets/12')).called(1);
    });

    test('propage l erreur quand le ticket est introuvable', () async {
      when(() => dio.get('/tickets/999')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tickets/999'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/tickets/999'),
            statusCode: 404,
          ),
        ),
      );

      expect(() => datasource.getTicketById(999), throwsA(isA<DioException>()));
    });
  });

  group('createTicket', () {
    final body = {'title': 'Ecran hors service', 'assetId': 21};

    test('envoie le corps de la requete en POST', () async {
      when(
        () => dio.post('/tickets', data: body),
      ).thenAnswer((_) async => responseWith(ticketJson(), '/tickets'));

      final result = await datasource.createTicket(body);

      expect(result.id, 12);
      verify(() => dio.post('/tickets', data: body)).called(1);
    });

    test('propage l erreur en cas de requete invalide', () async {
      when(() => dio.post('/tickets', data: body)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/tickets')),
      );

      expect(() => datasource.createTicket(body), throwsA(isA<DioException>()));
    });
  });

  group('updateTicketStatus', () {
    test('envoie le statut en PATCH sur la route du ticket', () async {
      when(
        () => dio.patch('/tickets/12', data: {'status': 'RESOLVED'}),
      ).thenAnswer(
        (_) async =>
            responseWith(ticketJson(status: 'RESOLVED'), '/tickets/12'),
      );

      final result = await datasource.updateTicketStatus(12, 'RESOLVED');

      expect(result.status, 'RESOLVED');
      verify(
        () => dio.patch('/tickets/12', data: {'status': 'RESOLVED'}),
      ).called(1);
    });
  });

  group('assignTechnician', () {
    test('envoie l assigne en PATCH', () async {
      when(
        () => dio.patch('/tickets/12', data: {'assigneeId': 7}),
      ).thenAnswer((_) async => responseWith(ticketJson(), '/tickets/12'));

      await datasource.assignTechnician(12, 7);

      verify(() => dio.patch('/tickets/12', data: {'assigneeId': 7})).called(1);
    });

    test('transmet un assigne nul pour desassigner', () async {
      when(
        () => dio.patch('/tickets/12', data: {'assigneeId': null}),
      ).thenAnswer((_) async => responseWith(ticketJson(), '/tickets/12'));

      await datasource.assignTechnician(12, null);

      verify(
        () => dio.patch('/tickets/12', data: {'assigneeId': null}),
      ).called(1);
    });
  });

  group('addComment', () {
    test('poste le commentaire sur la route actions', () async {
      when(
        () => dio.post(
          '/tickets/12/actions',
          data: {'content': 'Prise en charge'},
        ),
      ).thenAnswer((_) async => responseWith(null, '/tickets/12/actions'));

      await datasource.addComment(12, 'Prise en charge');

      verify(
        () => dio.post(
          '/tickets/12/actions',
          data: {'content': 'Prise en charge'},
        ),
      ).called(1);
    });

    test('propage l erreur levee par le client HTTP', () async {
      when(
        () => dio.post(
          '/tickets/12/actions',
          data: {'content': 'Prise en charge'},
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/tickets/12/actions'),
        ),
      );

      expect(
        () => datasource.addComment(12, 'Prise en charge'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
