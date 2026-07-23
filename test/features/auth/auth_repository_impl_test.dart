import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:itam_app/features/auth/data/models/user_model.dart';
import 'package:itam_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:itam_app/features/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource datasource;
  late AuthRepositoryImpl repository;

  setUp(() {
    datasource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(datasource);
  });

  UserModel modelWith({String role = 'TECHNICIAN', int? locationId = 5}) =>
      UserModel.fromJson({
        'id': 3,
        'email': 'claire.martin@exemple.fr',
        'role': role,
        'firstName': 'Claire',
        'lastName': 'Martin',
        'locationId': locationId,
      });

  group('login', () {
    test(
      'transmet les identifiants et convertit le modele en entite',
      () async {
        when(
          () => datasource.login(
            email: 'claire.martin@exemple.fr',
            password: 'motdepasse',
          ),
        ).thenAnswer((_) async => modelWith());

        final result = await repository.login(
          email: 'claire.martin@exemple.fr',
          password: 'motdepasse',
        );

        expect(result, isA<User>());
        expect(result.id, 3);
        expect(result.email, 'claire.martin@exemple.fr');
        expect(result.role, 'TECHNICIAN');
        verify(
          () => datasource.login(
            email: 'claire.martin@exemple.fr',
            password: 'motdepasse',
          ),
        ).called(1);
      },
    );

    test('conserve le role transmis par le serveur', () async {
      when(
        () =>
            datasource.login(email: 'admin@exemple.fr', password: 'motdepasse'),
      ).thenAnswer((_) async => modelWith(role: 'ADMIN'));

      final result = await repository.login(
        email: 'admin@exemple.fr',
        password: 'motdepasse',
      );

      expect(result.role, 'ADMIN');
    });

    test('propage l exception en cas d identifiants invalides', () async {
      when(
        () => datasource.login(
          email: 'claire.martin@exemple.fr',
          password: 'mauvais',
        ),
      ).thenThrow(Exception('Identifiants invalides'));

      expect(
        () => repository.login(
          email: 'claire.martin@exemple.fr',
          password: 'mauvais',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('logout', () {
    test('delegue la deconnexion au datasource', () async {
      when(() => datasource.logout()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => datasource.logout()).called(1);
    });

    test('propage l exception levee par le datasource', () async {
      when(() => datasource.logout()).thenThrow(Exception('Erreur reseau'));

      expect(() => repository.logout(), throwsA(isA<Exception>()));
    });
  });

  group('getCurrentUser', () {
    test('convertit le modele en entite quand une session existe', () async {
      when(
        () => datasource.getCurrentUser(),
      ).thenAnswer((_) async => modelWith());

      final result = await repository.getCurrentUser();

      expect(result, isA<User>());
      expect(result!.id, 3);
      expect(result.locationId, 5);
      verify(() => datasource.getCurrentUser()).called(1);
    });

    test('retourne null quand aucune session n est active', () async {
      when(() => datasource.getCurrentUser()).thenAnswer((_) async => null);

      final result = await repository.getCurrentUser();

      expect(result, isNull);
    });

    test('conserve un site de rattachement nul', () async {
      when(
        () => datasource.getCurrentUser(),
      ).thenAnswer((_) async => modelWith(locationId: null));

      final result = await repository.getCurrentUser();

      expect(result, isNotNull);
      expect(result!.locationId, isNull);
    });

    test('propage l exception levee par le datasource', () async {
      when(
        () => datasource.getCurrentUser(),
      ).thenThrow(Exception('Session illisible'));

      expect(() => repository.getCurrentUser(), throwsA(isA<Exception>()));
    });
  });
}
