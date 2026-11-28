/// Application-wide constants.
abstract final class AppConstants {
  static const appName = 'UNDERGROUND SCAN AI';
  static const appVersion = '0.1.0 (Phase 1)';

  static const minPasswordLength = 8;

  /// Minimum time the splash screen stays visible, so the brand animation
  /// can play even when bootstrapping is instantaneous.
  static const splashMinDuration = Duration(milliseconds: 1800);

  static const supportedLanguageCodes = ['fr', 'ar'];
}
