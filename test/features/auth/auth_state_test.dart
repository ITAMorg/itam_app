import 'package:flutter_test/flutter_test.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/auth/domain/entities/user.dart';

/// Tests unitaires purs sur la classe AuthState.
///
/// Ces tests valident le comportement de la classe d'état (immutabilité,
/// copyWith, valeurs par défaut) sans aucune dépendance à Flutter, Riverpod
/// ou au réseau. Ce sont les tests les plus rapides et les plus déterministes
/// du projet.
void main() {
  group('AuthState', () {
    test('a un status initial par défaut avec user et errorMessage à null', () {
      const state = AuthState();

      expect(state.status, AuthStatus.initial);
      expect(state.user, isNull);
      expect(state.errorMessage, isNull);
    });

    test('accepte des valeurs personnalisées via le constructeur', () {
      final user = User(
        id: 1,
        email: 'test@example.com',
        firstName: 'Jean',
        lastName: 'Dupont',
        role: 'USER',
      );

      final state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
        errorMessage: null,
      );

      expect(state.status, AuthStatus.authenticated);
      expect(state.user, user);
    });

    test('copyWith modifie uniquement les champs fournis', () {
      const initial = AuthState(
        status: AuthStatus.initial,
        errorMessage: 'ancien message',
      );

      // On modifie uniquement le status : le errorMessage doit être préservé
      final updated = initial.copyWith(status: AuthStatus.loading);

      expect(updated.status, AuthStatus.loading);
      expect(updated.errorMessage, 'ancien message');
    });

    test('copyWith sans argument retourne un état équivalent (immutabilité)', () {
      const initial = AuthState(
        status: AuthStatus.error,
        errorMessage: 'Login failed',
      );

      final copy = initial.copyWith();

      // Vérifie qu'aucun champ n'a été perdu au passage
      expect(copy.status, initial.status);
      expect(copy.user, initial.user);
      expect(copy.errorMessage, initial.errorMessage);
    });
  });
}