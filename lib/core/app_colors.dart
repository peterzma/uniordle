import 'package:flutter/material.dart';

class AppColors {
  // Game Logic
  static const Color correctColor = Color(0xFF538D4E);   // Success / Correct
  static const Color inWordColor = Color(0XFFDAC316); // Warning / In Word
  static const Color notInWordColor = Color(0xFF3A3A3C);   // Gray / Not in Word
  
  // Backgrounds
  static const Color surface = Color(0xFF00121f);   // Main dark background
  static const Color surfaceVariant = Color(0xFF1E293B); // Cards, tiles, keyboard buttons
  
  // Content (Text/Icons)
  static const Color onSurface = Color(0xFFF8FAFC);        // High emphasis text
  static const Color onSurfaceVariant = Color(0xFF94A3B8); // Medium emphasis / secondary text / inactive
  static const Color accent = Colors.blue;                 // Active icons/selection

  
  // Borders of non-selected buttons
  static const Color outline = Colors.white10;
}