import 'package:uniordle/shared/exports/app_exports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsDark.surface,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColorsDark.surfaceDialog,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      colorScheme: const ColorScheme.dark(
        surface: AppColorsDark.surface,
        onSurface: AppColorsDark.onSurface,
        primary: AppColorsDark.accent,
        secondary: AppColorsDark.accent3,
        error: AppColorsDark.accent2,

        outline: AppColorsDark.outline,
        surfaceContainer: AppColorsDark.surfaceVariant,
        onSurfaceVariant: AppColorsDark.onSurfaceVariant,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColorsLight.surface,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColorsLight.surfaceDialog,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      colorScheme: const ColorScheme.light(
        surface: AppColorsLight.surface,
        onSurface: AppColorsLight.onSurface,
        primary: AppColorsLight.accent,
        secondary: AppColorsLight.accent3,
        error: AppColorsLight.accent2,

        outline: AppColorsLight.outline,
        surfaceContainer: AppColorsLight.surfaceVariant,
        onSurfaceVariant: AppColorsLight.onSurfaceVariant,
      ),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final Color primaryText = isDark
        ? AppColorsDark.onSurface
        : AppColorsLight.onSurface;
    final Color secondaryText = isDark
        ? AppColorsDark.onSurfaceVariant
        : AppColorsLight.onSurfaceVariant;
    final Color accentText = isDark
        ? AppColorsDark.accent
        : AppColorsLight.accent;

    return TextTheme(
      displayLarge: AppFonts.displayLarge.copyWith(color: primaryText),
      displayMedium: AppFonts.displayMedium.copyWith(color: primaryText),
      headlineMedium: AppFonts.headlineMedium.copyWith(color: primaryText),
      labelLarge: AppFonts.labelLarge.copyWith(color: primaryText),
      labelMedium: AppFonts.labelMedium.copyWith(color: secondaryText),
      labelSmall: AppFonts.labelSmall.copyWith(color: accentText),
    );
  }
}
