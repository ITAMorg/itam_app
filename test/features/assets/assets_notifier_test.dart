import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/domain/repositories/asset_repository.dart';
import 'package:itam_app/features/assets/presentation/providers/assets_provider.dart';
import 'package:itam_app/features/auth/domain/entities/user.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

/// AuthNotifier de test : émet un state fixe défini au build().
/// Permet de simuler un user connecté avec un rôle et une location précis
/// sans avoir à passer par la vraie logique login/logout.
class FakeAuthNotifier extends AuthNotifier {
  FakeAuthNotifier(this._initialState);
  final AuthState _initialState;

  @override
  AuthState build() => _initialState;
}

/// Tests du AssetsNotifier — le notifier qui expose la liste des assets
/// avec filtrage RBAC côté client (USER → assets de sa location uniquement).
void main() {
  // Utilisateurs types
  final adminUser = User(
    id: 1,
    email: 'admin@test.local',
    firstName: 'Admin',
    lastName: 'Test',
    role: 'ADMIN',
  );

  final regularUser = User(
    id: 2,
    email: 'user@test.local',
    firstName: 'User',
    lastName: 'Paris',
    role: 'USER',
    locationId: 42, // location "Paris"
  );

  // Asset type basique réutilisable
  final laptopType = const AssetType(
    id: 1,
    name: 'Laptop',
    iconKey: 'laptop',
    colorKey: '1D4ED8',
  );

  // Deux assets pour tester le filtrage
  final parisAsset = Asset(
    id: '1',
    name: 'MacBook Pro Paris',
    serialNumber: 'SN-PARIS-001',
    status: AssetStatus.inService,
    assetType: laptopType,
    location: const AssetLocation(id: 42, name: 'Paris'),
    purchaseDate: DateTime(2025, 1, 1),
  );

  final lyonAsset = Asset(
    id: '2',
    name: 'Dell Latitude Lyon',
    serialNumber: 'SN-LYON-002',
    status: AssetStatus.inService,
    assetType: laptopType,
    location: const AssetLocation(id: 99, name: 'Lyon'),
    purchaseDate: DateTime(2025, 1, 1),
  );

  late MockAssetRepository mockRepository;

  setUp(() {
    mockRepository = MockAssetRepository();
  });

  /// Helper : construit un ProviderContainer avec les overrides nécessaires
  /// et un auth notifier retournant le state fourni.
  ProviderContainer buildContainer(AuthState authState) {
    final container = ProviderContainer(
      overrides: [
        assetRepositoryProvider.overrideWithValue(mockRepository),
        authNotifierProvider.overrideWith(
          () => FakeAuthNotifier(authState),
        ),
      ],
    );

    // Écoute active pour éviter l'auto-dispose
    container.listen(assetsProvider, (_, __) {}, fireImmediately: true);
    return container;
  }

  group('AssetsNotifier', () {
    test('retourne une liste vide quand aucun user n\'est authentifié',
        () async {
      const authState = AuthState(status: AuthStatus.unauthenticated);
      final container = buildContainer(authState);
      addTearDown(container.dispose);

      // Attente de la résolution du Future du build
      final assets = await container.read(assetsProvider.future);

      expect(assets, isEmpty);
      // Aucune méthode du repository ne doit avoir été appelée
      verifyNever(() => mockRepository.getAssets());
      verifyNever(() => mockRepository.getAssetsByLocation(any()));
    });

    test('un ADMIN reçoit TOUS les assets (pas de filtrage par location)',
        () async {
      when(() => mockRepository.getAssets())
          .thenAnswer((_) async => [parisAsset, lyonAsset]);

      final authState = AuthState(status: AuthStatus.authenticated, user: adminUser);
      final container = buildContainer(authState);
      addTearDown(container.dispose);

      final assets = await container.read(assetsProvider.future);

      expect(assets, hasLength(2));
      expect(assets, containsAll([parisAsset, lyonAsset]));
      verify(() => mockRepository.getAssets()).called(1);
      // Le filtrage par location NE doit PAS avoir été appelé pour un ADMIN
      verifyNever(() => mockRepository.getAssetsByLocation(any()));
    });

    test('un USER avec locationId reçoit UNIQUEMENT les assets de sa location',
        () async {
      // Simule le comportement API : getByLocation retourne seulement Paris
      when(() => mockRepository.getAssetsByLocation(42))
          .thenAnswer((_) async => [parisAsset]);

      final authState = AuthState(status: AuthStatus.authenticated, user: regularUser);
      final container = buildContainer(authState);
      addTearDown(container.dispose);

      final assets = await container.read(assetsProvider.future);

      expect(assets, hasLength(1));
      expect(assets.first.id, parisAsset.id);
      // La méthode getByLocation a été appelée avec la bonne location
      verify(() => mockRepository.getAssetsByLocation(42)).called(1);
      // Et getAssets() ne doit PAS avoir été appelé (économie d'un round-trip inutile)
      verifyNever(() => mockRepository.getAssets());
    });
  });
}