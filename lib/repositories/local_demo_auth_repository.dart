import '../core/services/preferences_service.dart';
import '../models/app_user.dart';
import 'auth_repository.dart';

/// A demo account of the local directory.
class DemoAccount {
  const DemoAccount(this.user);
  final AppUser user;
}

/// Local, offline authentication used until Firebase is configured (Phase 2).
///
/// DEMO ONLY: accounts and the shared password below are intentionally
/// public and grant access to nothing but local demo content. This class must
/// not be used in a production build.
class LocalDemoAuthRepository extends AuthRepository {
  LocalDemoAuthRepository(this._prefs, {this.latency = const Duration(milliseconds: 600)});

  final PreferencesService _prefs;

  /// Simulated network latency so the UI loading states are exercised.
  final Duration latency;

  static const demoPassword = 'Demo@2026';

  static const accounts = <DemoAccount>[
    DemoAccount(AppUser(
      id: 'demo-admin',
      email: 'admin@demo.local',
      displayName: 'Admin Démo',
      role: UserRole.administrator,
      isDemo: true,
    )),
    DemoAccount(AppUser(
      id: 'demo-maintenance',
      email: 'maintenance@demo.local',
      displayName: 'Technicien Démo',
      role: UserRole.maintenance,
      isDemo: true,
    )),
    DemoAccount(AppUser(
      id: 'demo-hse',
      email: 'hse@demo.local',
      displayName: 'Responsable HSE Démo',
      role: UserRole.hse,
      isDemo: true,
    )),
    DemoAccount(AppUser(
      id: 'demo-inspector',
      email: 'inspecteur@demo.local',
      displayName: 'Inspecteur Démo',
      role: UserRole.inspector,
      isDemo: true,
    )),
  ];

  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  bool get isDemo => true;

  AppUser? _find(String email) {
    final normalized = email.trim().toLowerCase();
    for (final a in accounts) {
      if (a.user.email == normalized) return a.user;
    }
    return null;
  }

  @override
  Future<void> restoreSession() async {
    final email = _prefs.demoSessionEmail;
    final user = email == null ? null : _find(email);
    if (user != null && user.id != _currentUser?.id) {
      _currentUser = user;
      notifyListeners();
    }
  }

  @override
  Future<AppUser> signInWithEmail({required String email, required String password}) async {
    await Future<void>.delayed(latency);
    final user = _find(email);
    if (user == null || password != demoPassword) {
      throw const AuthException(AuthErrorCode.invalidCredentials);
    }
    await _prefs.setDemoSessionEmail(user.email);
    _currentUser = user;
    notifyListeners();
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // No mail infrastructure exists in demo mode: report it honestly
    // instead of pretending an e-mail was sent.
    throw const AuthException(AuthErrorCode.unavailableInDemoMode);
  }

  @override
  Future<void> signOut() async {
    await _prefs.setDemoSessionEmail(null);
    _currentUser = null;
    notifyListeners();
  }
}
