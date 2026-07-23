import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/assets/data/datasources/asset_remote_datasource.dart';
import 'package:itam_app/features/assets/data/models/asset_model.dart';
import 'package:itam_app/features/assets/data/repositories/asset_repository_impl.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class MockAssetRemoteDataSource extends Mock implements AssetRemoteDataSource {}

void main() {
  late MockAssetRemoteDataSource datasource;
  late AssetRepositoryImpl repository;

  setUp(() {
    datasource = MockAssetRemoteDataSource();
    repository = AssetRepositoryImpl(datasource);
  });

  AssetModel modelWith({int id = 21, String name = 'Ecran Dell'}) =>
      AssetModel.fromJson({
        'id': id,
        'name': name,
        'serialNumber': 'SN-$id',
        'status': 'IN_SERVICE',
        'type': {
          'id': 2,
          'name': 'Ecran',
          'iconKey': 'monitor',
          'colorKey': 'blue',
        },
        'location': {'id': 5, 'name': 'Batiment A'},
        'purchaseDate': '2024-09-01T00:00:00.000Z',
      });

  group('getAssets', () {
    test('delegue au datasource et convertit les modeles en entites', () async {
      when(
        () => datasource.getAssets(),
      ).thenAnswer((_) async => [modelWith(id: 21), modelWith(id: 22)]);

      final result = await repository.getAssets();

      expect(result, isA<List<Asset>>());
      expect(result, hasLength(2));
      expect(result.first.id, '21');
      expect(result.first.status, AssetStatus.inService);
      verify(() => datasource.getAssets()).called(1);
    });

    test(
      'retourne une liste vide quand le datasource ne renvoie rien',
      () async {
        when(() => datasource.getAssets()).thenAnswer((_) async => []);

        final result = await repository.getAssets();

        expect(result, isEmpty);
      },
    );

    test('propage l exception levee par le datasource', () async {
      when(() => datasource.getAssets()).thenThrow(Exception('Erreur reseau'));

      expect(() => repository.getAssets(), throwsA(isA<Exception>()));
    });
  });

  group('getAssetsByLocation', () {
    test('transmet l identifiant de site au datasource', () async {
      when(
        () => datasource.getAssetsByLocation(5),
      ).thenAnswer((_) async => [modelWith()]);

      final result = await repository.getAssetsByLocation(5);

      expect(result, hasLength(1));
      verify(() => datasource.getAssetsByLocation(5)).called(1);
    });

    test('propage l exception levee par le datasource', () async {
      when(
        () => datasource.getAssetsByLocation(99),
      ).thenThrow(Exception('Site inconnu'));

      expect(
        () => repository.getAssetsByLocation(99),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getAssetById', () {
    test('transmet l identifiant et convertit le modele', () async {
      when(
        () => datasource.getAssetById('21'),
      ).thenAnswer((_) async => modelWith(id: 21, name: 'Ecran Dell'));

      final result = await repository.getAssetById('21');

      expect(result, isA<Asset>());
      expect(result.id, '21');
      expect(result.name, 'Ecran Dell');
      verify(() => datasource.getAssetById('21')).called(1);
    });

    test('propage l exception quand l equipement est introuvable', () async {
      when(
        () => datasource.getAssetById('999'),
      ).thenThrow(Exception('Asset non trouve'));

      expect(() => repository.getAssetById('999'), throwsA(isA<Exception>()));
    });
  });

  group('updateLocation', () {
    test('transmet les deux arguments et convertit le modele', () async {
      when(
        () => datasource.updateLocation('21', 7),
      ).thenAnswer((_) async => modelWith(id: 21));

      final result = await repository.updateLocation('21', 7);

      expect(result, isA<Asset>());
      expect(result.id, '21');
      verify(() => datasource.updateLocation('21', 7)).called(1);
    });

    test('accepte un site nul pour detacher l equipement', () async {
      when(
        () => datasource.updateLocation('21', null),
      ).thenAnswer((_) async => modelWith(id: 21));

      await repository.updateLocation('21', null);

      verify(() => datasource.updateLocation('21', null)).called(1);
    });

    test('propage l exception levee par le datasource', () async {
      when(
        () => datasource.updateLocation('21', 7),
      ).thenThrow(Exception('Mise a jour refusee'));

      expect(
        () => repository.updateLocation('21', 7),
        throwsA(isA<Exception>()),
      );
    });
  });
}
