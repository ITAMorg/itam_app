import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/assets/data/datasources/asset_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late AssetRemoteDataSourceImpl datasource;

  setUp(() {
    dio = MockDio();
    datasource = AssetRemoteDataSourceImpl(dio);
  });

  Map<String, dynamic> assetJson({int id = 21}) => {
    'id': id,
    'name': 'Ecran Dell',
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
  };

  Response<dynamic> responseWith(dynamic data, String path) =>
      Response<dynamic>(
        requestOptions: RequestOptions(path: path),
        data: data,
        statusCode: 200,
      );

  group('getAssets', () {
    test('appelle la route liste et deserialise la reponse', () async {
      when(() => dio.get('/assets')).thenAnswer(
        (_) async =>
            responseWith([assetJson(id: 21), assetJson(id: 22)], '/assets'),
      );

      final result = await datasource.getAssets();

      expect(result, hasLength(2));
      expect(result.first.id, 21);
      verify(() => dio.get('/assets')).called(1);
    });

    test('retourne une liste vide quand la reponse est vide', () async {
      when(
        () => dio.get('/assets'),
      ).thenAnswer((_) async => responseWith(<dynamic>[], '/assets'));

      expect(await datasource.getAssets(), isEmpty);
    });

    test('propage l erreur reseau', () async {
      when(() => dio.get('/assets')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/assets'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(() => datasource.getAssets(), throwsA(isA<DioException>()));
    });
  });

  group('getAssetsByLocation', () {
    test('construit la route avec l identifiant de site', () async {
      when(() => dio.get('/assets/location/5')).thenAnswer(
        (_) async => responseWith([assetJson()], '/assets/location/5'),
      );

      final result = await datasource.getAssetsByLocation(5);

      expect(result, hasLength(1));
      verify(() => dio.get('/assets/location/5')).called(1);
    });

    test('propage l erreur levee par le client HTTP', () async {
      when(() => dio.get('/assets/location/99')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/assets/location/99'),
        ),
      );

      expect(
        () => datasource.getAssetsByLocation(99),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('getAssetById', () {
    test('construit la route avec l identifiant', () async {
      when(
        () => dio.get('/assets/21'),
      ).thenAnswer((_) async => responseWith(assetJson(), '/assets/21'));

      final result = await datasource.getAssetById('21');

      expect(result.id, 21);
      expect(result.name, 'Ecran Dell');
      verify(() => dio.get('/assets/21')).called(1);
    });

    test('propage l erreur quand l equipement est introuvable', () async {
      when(() => dio.get('/assets/999')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/assets/999'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/assets/999'),
            statusCode: 404,
          ),
        ),
      );

      expect(
        () => datasource.getAssetById('999'),
        throwsA(isA<DioException>()),
      );
    });
  });

  group('updateLocation', () {
    test('envoie le PATCH puis relit l equipement mis a jour', () async {
      when(
        () => dio.patch('/assets/21/location', data: {'locationId': 7}),
      ).thenAnswer((_) async => responseWith(null, '/assets/21/location'));
      when(
        () => dio.get('/assets/21'),
      ).thenAnswer((_) async => responseWith(assetJson(), '/assets/21'));

      final result = await datasource.updateLocation('21', 7);

      expect(result.id, 21);
      verifyInOrder([
        () => dio.patch('/assets/21/location', data: {'locationId': 7}),
        () => dio.get('/assets/21'),
      ]);
    });

    test('transmet un site nul pour detacher l equipement', () async {
      when(
        () => dio.patch('/assets/21/location', data: {'locationId': null}),
      ).thenAnswer((_) async => responseWith(null, '/assets/21/location'));
      when(
        () => dio.get('/assets/21'),
      ).thenAnswer((_) async => responseWith(assetJson(), '/assets/21'));

      await datasource.updateLocation('21', null);

      verify(
        () => dio.patch('/assets/21/location', data: {'locationId': null}),
      ).called(1);
    });

    test('n effectue pas la relecture si la mise a jour echoue', () async {
      when(
        () => dio.patch('/assets/21/location', data: {'locationId': 7}),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/assets/21/location'),
        ),
      );

      expect(
        () => datasource.updateLocation('21', 7),
        throwsA(isA<DioException>()),
      );
      verifyNever(() => dio.get('/assets/21'));
    });
  });
}
