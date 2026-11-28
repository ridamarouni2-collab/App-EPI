/// Roles defined by the access-control model (enforced server-side by
/// Firestore security rules from Phase 2 onward).
enum UserRole {
  administrator,
  maintenance,
  hse,
  inspector;

  static UserRole fromName(String name) => UserRole.values.firstWhere(
        (r) => r.name == name,
        orElse: () => UserRole.inspector,
      );
}

class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.isDemo = false,
  });

  final String id;
  final String email;
  final String displayName;
  final UserRole role;

  /// True when the account comes from the local demo directory rather than
  /// a real identity provider.
  final bool isDemo;

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    return parts.take(2).map((p) => p.isEmpty ? '' : p[0].toUpperCase()).join();
  }
}
