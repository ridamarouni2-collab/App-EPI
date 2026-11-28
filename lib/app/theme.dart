import 'package:material_ui/material_ui.dart';

/// Brand palette of UNDERGROUND SCAN AI.
abstract final class AppColors {
  static const navy = Color(0xFF10243B);
  static const navyLight = Color(0xFF1C3A5C);
  static const green = Color(0xFF20A66A);
  static const orange = Color(0xFFF39C12);
  static const red = Color(0xFFD93636);
  static const lightBackground = Color(0xFFF2F5F8);

  /// Blue used for routes imported from engineering documentation.
  static const documentedBlue = Color(0xFF2F80ED);
  static const rejectedGrey = Color(0xFF7A8794);

  static const darkBackground = Color(0xFF0A1726);
  static const darkSurface = Color(0xFF13263B);
  static const darkSurfaceHigh = Color(0xFF1A3049);
}

abstract final class AppTheme {
  static const double radius = 16;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.navy,
      onPrimary: Colors.white,
      secondary: AppColors.green,
      onSecondary: Colors.white,
      tertiary: AppColors.orange,
      onTertiary: AppColors.navy,
      error: AppColors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.navy,
      surfaceContainerHighest: const Color(0xFFE3E9EF),
      outline: const Color(0xFFB9C4CF),
      outlineVariant: const Color(0xFFD9E0E7),
    );
    return _build(scheme, AppColors.lightBackground);
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.green,
      onPrimary: Colors.white,
      secondary: AppColors.green,
      onSecondary: Colors.white,
      tertiary: AppColors.orange,
      onTertiary: AppColors.navy,
      error: const Color(0xFFEF5A5A),
      onError: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: const Color(0xFFE6EDF4),
      surfaceContainerHighest: AppColors.darkSurfaceHigh,
      outline: const Color(0xFF4A6077),
      outlineVariant: const Color(0xFF2A4158),
    );
    return _build(scheme, AppColors.darkBackground);
  }

  static ThemeData _build(ColorScheme scheme, Color background) {
    final isDark = scheme.brightness == Brightness.dark;
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
    );
    final text = base.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );

    return base.copyWith(
      textTheme: text.copyWith(
        headlineSmall: text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        labelLarge: text.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: rounded.copyWith(
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.darkSurfaceHigh : const Color(0xFFF7F9FB),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.green, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
