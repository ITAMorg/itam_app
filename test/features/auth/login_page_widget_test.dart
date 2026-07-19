import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:itam_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:itam_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:itam_app/features/auth/presentation/pages/login_page.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

/// Tests widget de LoginPage.
///
/// Ces tests exercent le rendu et les interactions de la page de login
/// en environnement Flutter isolé, avec un ProviderScope surchargé pour
/// remplacer le repository d'authentification par un mock.
void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    when(() => mockRepository.getCurrentUser()).thenAnswer((_) async => null);
  });

  /// Helper : construit la LoginPage dans un environnement Flutter minimal.
  Widget buildTestApp() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    );
  }

  group('LoginPage', () {
    testWidgets('affiche les champs email, password et le bouton "Se connecter"',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump();

      expect(find.text('ADRESSE EMAIL'), findsOneWidget);
      expect(find.text('MOT DE PASSE'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Se connecter'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets(
        'le champ mot de passe a bien obscureText activé (masquage UX/sécurité)',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump();

      // On récupère les deux TextField
      final passwordField = tester.widget<TextField>(
        find.byType(TextField).at(1),
      );

      // Vérification directe de la propriété obscureText
      expect(passwordField.obscureText, isTrue,
          reason: 'Le champ password doit masquer la saisie utilisateur');

      // Sanity check : le champ email, lui, n'est PAS masqué
      final emailField = tester.widget<TextField>(
        find.byType(TextField).at(0),
      );
      expect(emailField.obscureText, isFalse,
          reason: 'Le champ email doit rester en clair');
    });

    testWidgets('appuyer sur le bouton déclenche login() sur le repository',
        (tester) async {
      // Configure le mock pour un login qui échoue immédiatement.
      // Peu importe le résultat : on veut juste vérifier que login() a été appelé
      // avec les bons arguments après le tap sur le bouton.
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => throw Exception('irrelevant for this test'));

      // Agrandir le viewport pour que le bouton soit visible sans scroll.
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(buildTestApp());
      await tester.pump();

      // Saisie des identifiants
      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), 'user@example.com');
      await tester.enterText(textFields.at(1), 'mysecret123');

      // Tap sur le bouton
      await tester.tap(find.text('Se connecter'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Vérification : le repository a été appelé avec les bons arguments
      verify(() => mockRepository.login(
            email: 'user@example.com',
            password: 'mysecret123',
          )).called(1);
    });
  });
}