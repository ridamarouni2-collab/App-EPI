import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Must be overridden at startup with a loaded [SharedPreferences] instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider not overridden'),
);

final preferencesServiceProvider = Provider<PreferencesService>(
  (ref) => PreferencesService(ref.watch(sharedPreferencesProvider)),
);

/// Typed wrapper around [SharedPreferences] for local, non-sensitive settings.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _kThemeMode = 'settings.themeMode';
  static const _kLanguage = 'settings.language';
  static const _kDemoData = 'settings.showDemoData';
  static const _kDemoSessionEmail = 'auth.demoSessionEmail';

  String? get themeMode => _prefs.getString(_kThemeMode);
  Future<void> setThemeMode(String value) => _prefs.setString(_kThemeMode, value);

  String? get languageCode => _prefs.getString(_kLanguage);
  Future<void> setLanguageCode(String value) => _prefs.setString(_kLanguage, value);

  bool get showDemoData => _prefs.getBool(_kDemoData) ?? false;
  Future<void> setShowDemoData(bool value) => _prefs.setBool(_kDemoData, value);

  String? get demoSessionEmail => _prefs.getString(_kDemoSessionEmail);
  Future<void> setDemoSessionEmail(String? value) => value == null
      ? _prefs.remove(_kDemoSessionEmail)
      : _prefs.setString(_kDemoSessionEmail, value);
}
