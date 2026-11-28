/// Evidence level of any underground-infrastructure information.
///
/// The app never presents a hypothesis as a fact: every pipe segment, point
/// or observation carries one of these statuses.
enum VerificationStatus {
  /// AI-generated or visual hypothesis, not confirmed.
  suspected,

  /// Imported from engineering drawings / as-built documentation.
  documented,

  /// Confirmed on site (excavation, inspection camera, GPR survey...).
  physicallyVerified,

  /// Investigated and ruled out.
  rejected;

  /// Firestore value (snake_case, as defined in the data model).
  String get firestoreValue => switch (this) {
        suspected => 'suspected',
        documented => 'documented',
        physicallyVerified => 'physically_verified',
        rejected => 'rejected',
      };

  static VerificationStatus fromFirestore(String value) =>
      VerificationStatus.values.firstWhere(
        (s) => s.firestoreValue == value,
        orElse: () => VerificationStatus.suspected,
      );
}
