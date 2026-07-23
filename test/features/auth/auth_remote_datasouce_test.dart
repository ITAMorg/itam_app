import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/core/errors/failures.dart';
import 'package:itam_app/features/auth/data/datasources/auth_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

/// Construit un jeton JWT non signe, decodable par JWT.decode
/// qui ne verifie pas la signature.
String buildToken(Map<String, dynamic> payload) {
  String encode(Map<String, dynamic> part) =>
      base64Url.encode(utf8.encode(jsonEncode(part))).replaceAll('=', '');
  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final body = encode(payload);
  return '$header.$body.signature';
}

void main() {
  late MockDio dio;
  late MockSecureStorage storage;
  late AuthRemoteDataSourceImpl datasource;

  setUp(() {
    dio = MockDio();
    storage = MockSecureStorage();
    datasource = AuthRemoteDataSourceImpl(dio, storage);
  });

  Response<dynamic> responseWith(dynamic data, String path) =>
      Response<dynamic>(
        requestOptions: RequestOptions(path: path),
        data: data,
        statusCode: 200,
      );

  Map<String, dynamic> loginPayload() => {
    'accessToken': 'jeton-acces',
    'refreshToken': 'jeton-rafraichissement',
    'user': {
      'id': 3,
      'email': 'claire.martin@exemple.fr',
      'role': 'TECHNICIAN',
      'firstName': 'Claire',
      'lastName': 'Martin',
      'locationId': 5,
    },
  };

  group('login', () {
    setUp(() {
      when(
        () => storage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
    });

    test('retourne l utilisateur et persiste les deux jetons', () async {
      when(
        () => dio.post(
          any(),
          data: {'email': 'claire.martin@exemple.fr', 'password': 'secret'},
        ),
      ).thenAnswer((_) async => responseWith(loginPayload(), '/auth/login'));

      final user = await datasource.login(
        email: 'claire.martin@exemple.fr',
        password: 'secret',
      );

      expect(user.id, 3);
      expect(user.role, 'TECHNICIAN');
      verify(
        () => storage.write(key: 'access_token', value: 'jeton-acces'),
      ).called(1);
      verify(
        () => storage.write(
          key: 'refresh_token',
          value: 'jeton-rafraichissement',
        ),
      ).called(1);
    });

    test('convertit un 401 en UnauthorizedFailure', () async {
      when(() => dio.post(any(), data: any(named: 'data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
          ),
        ),
      );

      expect(
        () => datasource.login(email: 'x@exemple.fr', password: 'mauvais'),
        throwsA(isA<UnauthorizedFailure>()),
      );
    });

    test('convertit une erreur de connexion en NetworkFailure', () async {
      when(() => dio.post(any(), data: any(named: 'data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => datasource.login(email: 'x@exemple.fr', password: 'secret'),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('convertit une erreur serveur en ServerFailure', () async {
      when(() => dio.post(any(), data: any(named: 'data'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 500,
            data: {'message': 'Erreur interne'},
          ),
        ),
      );

      expect(
        () => datasource.login(email: 'x@exemple.fr', password: 'secret'),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('convertit une reponse inattendue en UnknownFailure', () async {
      when(() => dio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => responseWith({'inattendu': true}, '/auth/login'),
      );

      expect(
        () => datasource.login(email: 'x@exemple.fr', password: 'secret'),
        throwsA(isA<UnknownFailure>()),
      );
    });
  });

  group('logout', () {
    test('appelle l API puis vide le stockage securise', () async {
      when(
        () => dio.post(any()),
      ).thenAnswer((_) async => responseWith(null, '/auth/logout'));
      when(() => storage.deleteAll()).thenAnswer((_) async {});

      await datasource.logout();

      verify(() => storage.deleteAll()).called(1);
    });

    test('vide le stockage meme si l appel API echoue', () async {
      when(() => dio.post(any())).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/auth/logout')),
      );
      when(() => storage.deleteAll()).thenAnswer((_) async {});

      await expectLater(datasource.logout(), throwsA(isA<DioException>()));
      verify(() => storage.deleteAll()).called(1);
    });
  });

  group('getCurrentUser', () {
    test('reconstruit l utilisateur depuis le jeton stocke', () async {
      final token = buildToken({
        'userId': 3,
        'email': 'claire.martin@exemple.fr',
        'role': 'TECHNICIAN',
        'locationId': 5,
      });
      when(
        () => storage.read(key: 'access_token'),
      ).thenAnswer((_) async => token);

      final user = await datasource.getCurrentUser();

      expect(user, isNotNull);
      expect(user!.id, 3);
      expect(user.email, 'claire.martin@exemple.fr');
      expect(user.role, 'TECHNICIAN');
      expect(user.locationId, 5);
    });

    test('accepte un jeton sans site de rattachement', () async {
      final token = buildToken({
        'userId': 1,
        'email': 'admin@exemple.fr',
        'role': 'ADMIN',
      });
      when(
        () => storage.read(key: 'access_token'),
      ).thenAnswer((_) async => token);

      final user = await datasource.getCurrentUser();

      expect(user, isNotNull);
      expect(user!.locationId, isNull);
    });

    test('retourne null quand aucun jeton n est stocke', () async {
      when(
        () => storage.read(key: 'access_token'),
      ).thenAnswer((_) async => null);

      expect(await datasource.getCurrentUser(), isNull);
    });

    test('retourne null quand le jeton est illisible', () async {
      when(
        () => storage.read(key: 'access_token'),
      ).thenAnswer((_) async => 'jeton-invalide');

      expect(await datasource.getCurrentUser(), isNull);
    });
  });

  group('getUsersByRole', () {
    test('construit la route avec le role demande', () async {
      when(() => dio.get('/users/role/TECHNICIAN')).thenAnswer(
        (_) async => responseWith([
          {
            'id': 7,
            'firstName': 'Paul',
            'lastName': 'Durand',
            'email': 'paul.durand@exemple.fr',
          },
        ], '/users/role/TECHNICIAN'),
      );

      final result = await datasource.getUsersByRole('TECHNICIAN');

      expect(result, hasLength(1));
      expect(result.first.id, 7);
      expect(result.first.email, 'paul.durand@exemple.fr');
      verify(() => dio.get('/users/role/TECHNICIAN')).called(1);
    });

    test(
      'retourne une liste vide quand aucun utilisateur ne correspond',
      () async {
        when(() => dio.get('/users/role/ADMIN')).thenAnswer(
          (_) async => responseWith(<dynamic>[], '/users/role/ADMIN'),
        );

        expect(await datasource.getUsersByRole('ADMIN'), isEmpty);
      },
    );
  });
}
