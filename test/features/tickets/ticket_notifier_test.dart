import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';
import 'package:itam_app/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_provider.dart';

class MockTicketRepository extends Mock implements TicketRepository {}

/// Tests du TicketNotifier — le notifier qui expose la liste des tickets.
///
/// Note sur le RBAC : contrairement à AssetsNotifier, ce notifier n'implémente
/// PAS de filtrage côté client. Le filtrage par rôle et location est délégué
/// exclusivement au serveur (single source of truth). Cette architecture est
/// couverte par 3 tests d'intégration côté API (tickets.test.ts).
void main() {
  // Requester type réutilisable
  final requester = const TicketUser(
    id: 1,
    firstName: 'Jean',
    lastName: 'Dupont',
    email: 'jean@test.local',
  );

  // Un ticket "OPEN" simple
  final openTicket = Ticket(
    id: 1,
    reference: 'TKT-2026-00001',
    type: TicketType.incident,
    status: TicketStatus.open,
    priority: TicketPriority.medium,
    title: 'Écran ne s\'allume plus',
    description: 'Depuis ce matin',
    createdAt: DateTime(2026, 7, 19, 9, 0),
    updatedAt: DateTime(2026, 7, 19, 9, 0),
    requester: requester,
    comments: const [],
  );

  // Un ticket "IN_PROGRESS" avec assignee
  final inProgressTicket = Ticket(
    id: 2,
    reference: 'TKT-2026-00002',
    type: TicketType.incident,
    status: TicketStatus.inProgress,
    priority: TicketPriority.high,
    title: 'Serveur inaccessible',
    description: 'Ping KO',
    createdAt: DateTime(2026, 7, 19, 8, 0),
    updatedAt: DateTime(2026, 7, 19, 10, 0),
    requester: requester,
    assignee: const TicketUser(
      id: 2,
      firstName: 'Marie',
      lastName: 'Technicien',
    ),
    comments: const [],
  );

  late MockTicketRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockTicketRepository();

    when(() => mockRepository.getTickets()).thenAnswer((_) async => []);

    container = ProviderContainer(
      overrides: [
        ticketRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('TicketNotifier', () {
    test('build() charge et expose la liste des tickets retournée par le repository',
        () async {
      // Le mock est configuré AVANT toute lecture du provider
      when(() => mockRepository.getTickets())
          .thenAnswer((_) async => [openTicket, inProgressTicket]);

      // Maintenant on peut activer l'écoute
      container.listen(ticketListProvider, (_, __) {}, fireImmediately: true);

      final tickets = await container.read(ticketListProvider.future);

      expect(tickets, hasLength(2));
      expect(tickets, containsAll([openTicket, inProgressTicket]));

      final state = container.read(ticketListProvider);
      expect(state, isA<AsyncData<List<Ticket>>>());

      verify(() => mockRepository.getTickets()).called(1);
    });

    test('build() propage l\'erreur du repository dans un AsyncError',
        () async {
      final exception = Exception('Network unreachable');
      when(() => mockRepository.getTickets()).thenThrow(exception);

      container.listen(ticketListProvider, (_, __) {}, fireImmediately: true);
      await pumpEventQueue();

      final state = container.read(ticketListProvider);
      expect(state, isA<AsyncError<List<Ticket>>>());
      expect(state.error, exception);

      verify(() => mockRepository.getTickets()).called(1);
    });

    test('refresh() déclenche un nouveau fetch et met à jour la liste',
        () async {
      // Premier fetch : le repo retourne 1 ticket
      when(() => mockRepository.getTickets())
          .thenAnswer((_) async => [openTicket]);

      container.listen(ticketListProvider, (_, __) {}, fireImmediately: true);

      var initialTickets = await container.read(ticketListProvider.future);
      expect(initialTickets, hasLength(1));

      // Changement du comportement du mock : cette fois retourner 2 tickets
      when(() => mockRepository.getTickets())
          .thenAnswer((_) async => [openTicket, inProgressTicket]);

      // Appel de refresh()
      final notifier = container.read(ticketListProvider.notifier);
      await notifier.refresh();

      // Le state contient maintenant la nouvelle liste
      final refreshedTickets = await container.read(ticketListProvider.future);
      expect(refreshedTickets, hasLength(2));

      // Le repository a été appelé 2 fois
      verify(() => mockRepository.getTickets()).called(2);
    });
  });
}