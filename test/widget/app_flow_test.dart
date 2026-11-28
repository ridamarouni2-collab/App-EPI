import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:underground_scan_ai/app/routes.dart';
import 'package:underground_scan_ai/features/dashboard/presentation/dashboard_screen.dart';
import 'package:underground_scan_ai/features/dashboard/presentation/widgets/module_tile.dart';
import 'package:underground_scan_ai/features/authentication/presentation/login_screen.dart';

import '../helpers.dart';

const _hseWarningFr =
    'AVERTISSEMENT : Réseau enterré possible. Ne pas percer avant vérification et autorisation.';

void main() {
  testWidgets('splash leads to login when no session exists', (tester) async {
    await pumpApp(tester);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Mode démonstration local'), findsOneWidget);
  });

  testWidgets('login form validates input', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.text("L'adresse e-mail est obligatoire"), findsOneWidget);
    expect(find.text('Le mot de passe est obligatoire'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('login.email')), 'not-an-email');
    await tester.enterText(find.byKey(const Key('login.password')), '123');
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.text('Adresse e-mail invalide'), findsOneWidget);
    expect(find.text('Au moins 8 caractères'), findsOneWidget);
  });

  testWidgets('wrong credentials show an error and stay on login', (tester) async {
    await pumpApp(tester);
    await signIn(tester, password: 'WrongPass1');
    expect(find.text('E-mail ou mot de passe incorrect'), findsOneWidget);
    expect(find.byType(DashboardScreen), findsNothing);
  });

  testWidgets('demo account picker fills the form', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Comptes de démonstration'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('hse@demo.local'));
    await tester.pump();
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text('Bonjour, Responsable HSE Démo'), findsOneWidget);
  });

  testWidgets('dashboard shows real (zero) indicators, HSE warning and locked modules',
      (tester) async {
    await pumpApp(tester);
    await signIn(tester);

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text(_hseWarningFr), findsOneWidget);
    expect(find.text('Inspections'), findsOneWidget);
    expect(find.text('Emplacements suspectés'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(5));
    expect(find.text('Aucune activité enregistrée'), findsOneWidget);
    // No demo banner unless explicitly enabled.
    expect(find.textContaining('Données de démonstration affichées'), findsNothing);

    // Not-yet-implemented modules are disabled, not fake buttons.
    final tiles = tester.widgetList<ModuleTile>(find.byType(ModuleTile));
    expect(tiles.length, 7);
    expect(tiles.every((t) => t.onTap == null), isTrue);
  });

  testWidgets('enabling demo data shows clearly labelled demo content', (tester) async {
    await pumpApp(tester);
    await signIn(tester);

    await tester.tap(find.byKey(const Key('dashboard.settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings.demoData')));
    await tester.pumpAndSettle();
    await goBack(tester);

    expect(find.textContaining('Données de démonstration affichées'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.textContaining('DEMO-SCAN-0027'), findsOneWidget);
  });

  testWidgets('switching to Arabic renders RTL and translated UI', (tester) async {
    await pumpApp(tester);
    await signIn(tester);

    await tester.tap(find.byKey(const Key('dashboard.settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings.lang.ar')));
    await tester.pumpAndSettle();

    expect(find.text('الإعدادات'), findsOneWidget);
    final dir = Directionality.of(tester.element(find.text('الإعدادات')));
    expect(dir, TextDirection.rtl);

    await goBack(tester);
    expect(find.text('لوحة التحكم'), findsOneWidget);
    expect(find.textContaining('تحذير'), findsOneWidget);
  });

  testWidgets('persisted session skips login; sign-out returns to login', (tester) async {
    await pumpApp(tester, prefs: {'auth.demoSessionEmail': 'admin@demo.local'});
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text('Administrateur'), findsOneWidget);

    await tester.tap(find.byKey(const Key('dashboard.settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings.signOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings.confirmSignOut')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('forgot password reports demo limitation honestly', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byKey(const Key('login.email')), 'hse@demo.local');
    await tester.tap(find.text('Mot de passe oublié ?'));
    await tester.pumpAndSettle();

    expect(find.text('Réinitialiser le mot de passe'), findsOneWidget);
    await tester.tap(find.byKey(const Key('reset.submit')));
    await tester.pumpAndSettle();
    expect(find.textContaining('indisponible en mode démonstration'), findsOneWidget);
    expect(find.textContaining('un lien de réinitialisation a été envoyé'), findsNothing);

    await tester.tap(find.text('Retour à la connexion'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('protected routes redirect to login when signed out', (tester) async {
    await pumpApp(tester);
    final container = ProviderScope.containerOf(tester.element(find.byType(LoginScreen)));
    for (final path in [AppRoutes.dashboard, AppRoutes.settings]) {
      container.read(routerProvider).go(path);
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget, reason: path);
      expect(find.byType(DashboardScreen), findsNothing);
    }
  });

  testWidgets('dashboard renders without overflow on a small phone', (tester) async {
    await pumpApp(tester, size: const Size(360, 740), prefs: {
      'auth.demoSessionEmail': 'inspecteur@demo.local',
      'settings.showDemoData': true,
    });
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic dashboard renders without overflow on a small phone', (tester) async {
    await pumpApp(tester, size: const Size(360, 1400), prefs: {
      'auth.demoSessionEmail': 'hse@demo.local',
      'settings.showDemoData': true,
      'settings.language': 'ar',
    });
    expect(find.text('لوحة التحكم'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
