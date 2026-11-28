import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:underground_scan_ai/app/app.dart';
import 'package:underground_scan_ai/core/constants/app_constants.dart';
import 'package:underground_scan_ai/core/services/preferences_service.dart';
import 'package:underground_scan_ai/features/authentication/application/auth_providers.dart';
import 'package:underground_scan_ai/repositories/local_demo_auth_repository.dart';

/// Boots the full app with in-memory preferences and waits past the splash.
Future<void> pumpApp(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  Size size = const Size(900, 2600),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  SharedPreferences.setMockInitialValues(prefs);
  final sp = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sp),
        authRepositoryProvider.overrideWith((ref) {
          final repo = LocalDemoAuthRepository(
            ref.watch(preferencesServiceProvider),
            latency: Duration.zero,
          );
          ref.onDispose(repo.dispose);
          return repo;
        }),
      ],
      child: const UndergroundScanApp(),
    ),
  );
  await tester.pump(AppConstants.splashMinDuration + const Duration(milliseconds: 100));
  await tester.pumpAndSettle();
}

Future<void> signIn(WidgetTester tester, {String email = 'inspecteur@demo.local', String? password}) async {
  await tester.enterText(find.byKey(const Key('login.email')), email);
  await tester.enterText(
    find.byKey(const Key('login.password')),
    password ?? LocalDemoAuthRepository.demoPassword,
  );
  await tester.tap(find.byKey(const Key('login.submit')));
  await tester.pumpAndSettle();
}

/// Taps the app bar back button (material_ui's BackButton, which
/// `tester.pageBack()` does not recognise).
Future<void> goBack(WidgetTester tester) async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}
