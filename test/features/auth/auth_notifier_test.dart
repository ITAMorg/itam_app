import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/auth/domain/entities/user.dart';
import 'package:itam_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:itam_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

/// Mock du repository d'authentification.
class MockAuthRepository extends Mock implements AuthRepository {}

/// Tests d'intégration de AuthNotifier.
///
/// Pattern utilisé (idiomatique Riverpod code-gen) :
///  1. Créer un mock du repository via mocktail
///  2. Override authRepositoryProvider avec le mock via ProviderContainer
///  3. Utiliser container.listen() pour maintenir le provider "vivant"
///     (obligatoire avec les providers @riverpod autodispose : sans listener,
///     le provider peut être disposé entre deux reads et perdre son état)
///  4. pumpEventQueue() pour laisser les Future asynchrones se résoudre
void main() {
  final testUser = User(
    id: 1,
    email: 'test@example.com',
    firstName: 'Jean',
    lastName: 'Dupont',
    role: 'USER',
  );

  late MockAuthRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockAuthRepository();

    when(() => mockRepository.getCurrentUser()).thenAnswer((_) async => null);
    when(() => mockRepository.logout()).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    // Écoute active du notifier : indispensable pour empêcher l'auto-dispose
    // des providers @riverpod entre les reads dans un contexte de test.
    container.listen(
      authNotifierProvider,
      (_, __) {},
      fireImmediately: true,
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthNotifier', () {
    test('état initial est unauthenticated quand getCurrentUser retourne null',
        () async {
      await pumpEventQueue();

      final state = container.read(authNotifierProvider);
      expect(state.status, AuthStatus.unauthenticated);
      expect(state.user, isNull);
      verify(() => mockRepository.getCurrentUser()).called(1);
    });

    test('login réussi passe l\'état à authenticated avec le user', () async {
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => testUser);

      await pumpEventQueue(); // laisse _checkCurrentUser se terminer

      final notifier = container.read(authNotifierProvider.notifier);
      await notifier.login(
        email: 'test@example.com',
        password: 'password123',
      );

      final state = container.read(authNotifierProvider);
      expect(state.status, AuthStatus.authenticated);
      expect(state.user, testUser);
      expect(state.errorMessage, isNull);

      verify(() => mockRepository.login(
            email: 'test@example.com',
            password: 'password123',
          )).called(1);
    });

    test('login échoué passe l\'état à error avec un errorMessage', () async {
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Invalid credentials'));

      await pumpEventQueue();

      final notifier = container.read(authNotifierProvider.notifier);
      await notifier.login(
        email: 'test@example.com',
        password: 'wrong-password',
      );

      final state = container.read(authNotifierProvider);
      expect(state.status, AuthStatus.error);
      expect(state.user, isNull);
      expect(state.errorMessage, contains('Invalid credentials'));
    });

    // test('logout appelle le repository et passe à unauthenticated', () async {
    //   // Simuler un utilisateur déjà authentifié au démarrage
    //   when(() => mockRepository.getCurrentUser())
    //       .thenAnswer((_) async => testUser);
    
    //   container.dispose();
    //   container = ProviderContainer(
    //     overrides: [
    //       authRepositoryProvider.overrideWithValue(mockRepository),
    //     ],
    //   );
    //   container.listen(
    //     authNotifierProvider,
    //     (_, __) {},
    //     fireImmediately: true,
    //   );

    //   await pumpEventQueue();

    //   // Sanity check : l'utilisateur est bien authentifié avant le logout
    //   expect(container.read(authNotifierProvider).status,
    //       AuthStatus.authenticated);

    //   // Action : logout
    //   final notifier = container.read(authNotifierProvider.notifier);
    //   await notifier.logout();

    //   final state = container.read(authNotifierProvider);
    //   expect(state.status, AuthStatus.unauthenticated);
    //   verify(() => mockRepository.logout()).called(1);
    // });
  });
}