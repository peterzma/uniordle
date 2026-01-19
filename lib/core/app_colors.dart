import 'package:flutter/material.dart';

class AppColors {
  // Logic Colours (Game States)
  static const Color correctColor = Color(0xFF538D4E);
  static const Color inWordColor = Color(0XFFDAC316);
  static const Color notInWordColor = Color(0xFF3A3A3C);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textOnAction = Colors.white;

  // Backgrounds
  static const Color tileBackground = Color(0xFF1E293B);
  static const Color mainBackground = Color(0xFF00121f);
  static const Color backgroundBorder = Color(0xFF1E293B);

  // Keyboard
  static const Color keyBackground = tileBackground;

  // UI Elements
  static const Color selectedIcon = Colors.blue;
  static const Color nonSelectedIcon = Colors.grey;
  static const Color selectedButton = selectedIcon;
  static const Color nonSelectedButton = disciplineTile;
  static const Color nonSelectedButtonBorder = disciplineTile;
  static const Color disciplineTile = tileBackground;
  static const Color loadingCircle = Color(0xFF0A0E17);
  static const Color shadow = Colors.black;

  // Slider & Controls
  static const Color sliderInactiveTrack = Colors.white24;
  static const Color sliderActiveTickMark = Colors.white54;
  static const Color sliderInactiveTickMark = Colors.white54;
}