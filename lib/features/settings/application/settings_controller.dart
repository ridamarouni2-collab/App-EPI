import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/services/preferences_service.dart';

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.locale,
    required this.showDemoData,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final bool showDemoData;

  AppSettings copyWith({ThemeMode? themeMode, Locale? locale, bool? showDemoData}) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
        showDemoData: showDemoData ?? this.showDemoData,
      );
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

/// User preferences (theme, language, demo data), persisted locally.
class SettingsController extends Notifier<AppSettings> {
  PreferencesService get _prefs => ref.read(preferencesServiceProvider);

  @override
  AppSettings build() {
    final prefs = ref.watch(preferencesServiceProvider);
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (m) => m.name == prefs.themeMode,
        orElse: () => ThemeMode.system,
      ),
      locale: Locale(prefs.languageCode == 'ar' ? 'ar' : 'fr'),
      showDemoData: prefs.showDemoData,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setThemeMode(mode.name);
  }

  Future<void> setLocale(Locale locale) async {
    state = state.copyWith(locale: locale);
    await _prefs.setLanguageCode(locale.languageCode);
  }

  Future<void> setShowDemoData(bool value) async {
    state = state.copyWith(showDemoData: value);
    await _prefs.setShowDemoData(value);
  }
}
