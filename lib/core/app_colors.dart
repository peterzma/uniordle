import 'package:flutter/material.dart';

abstract class AppColors {
  // Game Logic
  static const Color correctColor = Colors.green; // Success / Correct
  static const Color inWordColor = Color(0XFFEAD637); // Warning / In Word
  static const Color notInWordColor = Color(0xFF475569); // Gray / Not in Word
  
  // Backgrounds
  static const Color surface = Color(0xFF00121f); // Main dark background
  static const Color surfaceDialog = Color(0xFF060C16); // Main dark background
  static const Color surfaceVariant = Color(0x401A1F2E); // Cards, tiles, keyboard buttons
  static const Color gameTiles = Color(0xFF1A1F2E); // Cards, tiles, keyboard buttons
  
  // Content (Text/Icons)
  static const Color onSurface = Color(0xFFF8FAFC); // High emphasis text
  static const Color onSurfaceVariant = Color(0xFF94A3B8); // Medium emphasis / secondary text / inactive
  static const Color outline = Color(0xFF334155);

  // UI Accents
  static const Color accent = Color(0xFF3B82F6); // Active icons/selection / Basic
  static const Color accent2 = Color(0xFFEF4444); // Negative / Loss etc
  static const Color accent3 = Color(0xFFF4D35E); // Good, Merits / Positive
  static const Color accent4 = Color(0xFFF18F01); // Very good

  // Major Specific Colors
  static const Color majorEngineering = Color(0xFF00BCD4);
  static const Color majorCS = Color(0xFF448AFF);
  static const Color majorMedicine = Color(0xFFFF4081);
  static const Color majorLaw = Color(0xFFFFAB40);
  static const Color majorPsychology = Color(0xFFE040FB);
  static const Color majorArts = Color(0xFFFF5252);
  static const Color majorHumanities = Color(0xFFFFD740);
  static const Color majorEducation = Color(0xFF40C4FF);
  static const Color majorMaths = Color(0xFF7C4DFF);
  static const Color majorMusic = Color(0xFFEEFF41);
  static const Color majorArchitecture = Color(0xFF1DE9B6);
  static const Color majorNursing = Color(0xFFFF6E40);
  static const Color majorHistory = Color(0xFFA1887F);
  static const Color majorJournalism = Color(0xFF90A4AE);
  static const Color majorAstronomy = Color(0xFF536DFE);
  static const Color majorPhilosophy = Color(0xFFE0E0E0);
  static const Color majorPhysics = Color(0xFFB388FF);
  static const Color majorChemistry = Color(0xFF69F0AE);
  static const Color majorBiology = Color(0xFFB2FF59);
  static const Color majorEconomics = Color(0xFF00E676);
}