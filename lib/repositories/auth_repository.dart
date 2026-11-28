import 'package:material_ui/material_ui.dart' show ChangeNotifier;

import '../models/app_user.dart';

enum AuthErrorCode { invalidCredentials, unavailableInDemoMode, network, unknown }

class AuthException implements Exception {
  const AuthException(this.code);
  final AuthErrorCode code;

  @override
  String toString() => 'AuthException(${code.name})';
}

/// Authentication contract. Implementations notify listeners whenever
/// [currentUser] changes so routing can react.
///
/// Phase 1 ships [LocalDemoAuthRepository]; Phase 2 adds a Firebase
/// implementation behind the same interface.
abstract class AuthRepository extends ChangeNotifier {
  AppUser? get currentUser;

  /// Whether this implementation is a local demo (no real identity provider).
  bool get isDemo;

  /// Restores a persisted session, if any. Called once by the splash screen.
  Future<void> restoreSession();

  /// Throws [AuthException] on failure.
  Future<AppUser> signInWithEmail({required String email, required String password});

  /// Throws [AuthException] on failure.
  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
