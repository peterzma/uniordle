import 'package:uniordle/shared/exports/app_exports.dart';

abstract class AppFonts {
  static const String displayFont = 'Lexend';

  // Big Hero
  static TextStyle get displayLarge => const TextStyle(
    fontFamily: displayFont,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  static TextStyle get displayMedium => const TextStyle(
    fontFamily: displayFont,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  // Titles / Tiles
  static TextStyle get headlineMedium => const TextStyle(
    fontFamily: displayFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // UI / Labels (Buttons, Captions)
  static TextStyle get labelLarge => const TextStyle(
    fontFamily: displayFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get labelMedium => const TextStyle(
    fontFamily: displayFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get labelSmall => const TextStyle(
    fontFamily: displayFont,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}
