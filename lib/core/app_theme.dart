import 'package:uniordle/shared/exports/settings_exports.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppFonts.displayFont,
      scaffoldBackgroundColor: AppColors.surface,
    ).copyWith(
      textTheme: TextTheme(
        displayLarge: AppFonts.displayMedium,
        headlineMedium: AppFonts.displayLarge,
        labelLarge: AppFonts.labelLarge,
        labelSmall: AppFonts.labelMedium,
      )
    );
  }
}