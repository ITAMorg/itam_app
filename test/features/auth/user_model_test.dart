import 'package:flutter_test/flutter_test.dart';
import 'package:itam_app/features/auth/data/models/user_model.dart';

void main() {
  Map<String, dynamic> fullJson() => {
    'id': 3,
    'email': 'claire.martin@exemple.fr',
    'role': 'TECHNICIAN',
    'firstName': 'Claire',
    'lastName': 'Martin',
    'locationId': 5,
  };

  group('UserModel.fromJson', () {
    test('deserialise un utilisateur complet', () {
      final model = UserModel.fromJson(fullJson());

      expect(model.id, 3);
      expect(model.email, 'claire.martin@exemple.fr');
      expect(model.role, 'TECHNICIAN');
      expect(model.firstName, 'Claire');
      expect(model.lastName, 'Martin');
      expect(model.locationId, 5);
    });

    test('accepte un utilisateur sans site de rattachement', () {
      final json = fullJson()..remove('locationId');
      final model = UserModel.fromJson(json);

      expect(model.locationId, isNull);
    });

    test('accepte un site de rattachement explicitement nul', () {
      final json = fullJson()..['locationId'] = null;
      final model = UserModel.fromJson(json);

      expect(model.locationId, isNull);
    });

    test('deserialise chacun des trois roles', () {
      for (final role in ['ADMIN', 'TECHNICIAN', 'USER']) {
        final json = fullJson()..['role'] = role;
        expect(UserModel.fromJson(json).role, role);
      }
    });
  });

  group('UserModel.toJson', () {
    test('serialise un utilisateur complet', () {
      final json = UserModel.fromJson(fullJson()).toJson();

      expect(json['id'], 3);
      expect(json['email'], 'claire.martin@exemple.fr');
      expect(json['role'], 'TECHNICIAN');
      expect(json['firstName'], 'Claire');
      expect(json['lastName'], 'Martin');
      expect(json['locationId'], 5);
    });

    test('un aller-retour serialisation preserve les valeurs', () {
      final original = UserModel.fromJson(fullJson());
      final restored = UserModel.fromJson(original.toJson());

      expect(restored, equals(original));
    });
  });

  group('UserModel.copyWith', () {
    test('remplace uniquement le champ demande', () {
      final model = UserModel.fromJson(fullJson());
      final updated = model.copyWith(role: 'ADMIN');

      expect(updated.role, 'ADMIN');
      expect(updated.id, model.id);
      expect(updated.email, model.email);
      expect(updated.firstName, model.firstName);
    });

    test('deux instances de memes valeurs sont egales', () {
      final a = UserModel.fromJson(fullJson());
      final b = UserModel.fromJson(fullJson());

      expect(a, equals(b));
    });
  });

  group('UserModel.toEntity', () {
    test('reporte tous les champs sur l entite', () {
      final entity = UserModel.fromJson(fullJson()).toEntity();

      expect(entity.id, 3);
      expect(entity.email, 'claire.martin@exemple.fr');
      expect(entity.role, 'TECHNICIAN');
      expect(entity.firstName, 'Claire');
      expect(entity.lastName, 'Martin');
      expect(entity.locationId, 5);
    });

    test('conserve un site de rattachement nul', () {
      final json = fullJson()..['locationId'] = null;
      final entity = UserModel.fromJson(json).toEntity();

      expect(entity.locationId, isNull);
    });
  });
}
