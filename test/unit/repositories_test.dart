import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:underground_scan_ai/core/services/preferences_service.dart';
import 'package:underground_scan_ai/models/app_user.dart';
import 'package:underground_scan_ai/models/verification_status.dart';
import 'package:underground_scan_ai/repositories/auth_repository.dart';
import 'package:underground_scan_ai/repositories/dashboard_repository.dart';
import 'package:underground_scan_ai/repositories/local_demo_auth_repository.dart';

Future<PreferencesService> _prefs([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return PreferencesService(await SharedPreferences.getInstance());
}

void main() {
  group('LocalDemoAuthRepository', () {
    test('signs in a demo account, persists and notifies', () async {
      final prefs = await _prefs();
      final repo = LocalDemoAuthRepository(prefs, latency: Duration.zero);
      var notified = 0;
      repo.addListener(() => notified++);

      final user = await repo.signInWithEmail(
        email: '  HSE@demo.local ',
        password: LocalDemoAuthRepository.demoPassword,
      );

      expect(user.role, UserRole.hse);
      expect(user.isDemo, isTrue);
      expect(repo.currentUser?.id, 'demo-hse');
      expect(prefs.demoSessionEmail, 'hse@demo.local');
      expect(notified, 1);
    });

    test('rejects wrong password and unknown accounts', () async {
      final repo = LocalDemoAuthRepository(await _prefs(), latency: Duration.zero);
      expect(
        () => repo.signInWithEmail(email: 'hse@demo.local', password: 'wrongpass'),
        throwsA(isA<AuthException>()
            .having((e) => e.code, 'code', AuthErrorCode.invalidCredentials)),
      );
      expect(
        () => repo.signInWithEmail(
            email: 'nobody@demo.local', password: LocalDemoAuthRepository.demoPassword),
        throwsA(isA<AuthException>()),
      );
      expect(repo.currentUser, isNull);
    });

    test('restores and clears the persisted session', () async {
      final prefs = await _prefs({'auth.demoSessionEmail': 'admin@demo.local'});
      final repo = LocalDemoAuthRepository(prefs, latency: Duration.zero);
      expect(repo.currentUser, isNull);
      await repo.restoreSession();
      expect(repo.currentUser?.role, UserRole.administrator);

      await repo.signOut();
      expect(repo.currentUser, isNull);
      expect(prefs.demoSessionEmail, isNull);
    });

    test('password reset is reported as unavailable in demo mode', () async {
      final repo = LocalDemoAuthRepository(await _prefs(), latency: Duration.zero);
      expect(
        () => repo.sendPasswordResetEmail('hse@demo.local'),
        throwsA(isA<AuthException>()
            .having((e) => e.code, 'code', AuthErrorCode.unavailableInDemoMode)),
      );
    });
  });

  group('LocalDashboardRepository', () {
    test('returns real empty values without demo data', () async {
      final snap = await const LocalDashboardRepository().loadSnapshot(includeDemoData: false);
      expect(snap.containsDemoData, isFalse);
      expect(snap.stats.totalInspections, 0);
      expect(snap.stats.suspectedLocations, 0);
      expect(snap.recentActivities, isEmpty);
    });

    test('demo data is always flagged as demo', () async {
      final snap = await const LocalDashboardRepository().loadSnapshot(includeDemoData: true);
      expect(snap.containsDemoData, isTrue);
      expect(snap.recentActivities, isNotEmpty);
      expect(snap.recentActivities.every((a) => a.isDemo), isTrue);
      expect(snap.recentActivities.every((a) => a.reference.startsWith('DEMO-')), isTrue);
    });
  });

  test('VerificationStatus maps to Firestore snake_case values', () {
    expect(VerificationStatus.physicallyVerified.firestoreValue, 'physically_verified');
    for (final s in VerificationStatus.values) {
      expect(VerificationStatus.fromFirestore(s.firestoreValue), s);
    }
  });
}
