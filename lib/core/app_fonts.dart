import 'package:flutter/material.dart';

class GameFonts {
  static const TextStyle titleText = TextStyle(
    color: Colors.white, 
    fontSize: 24, 
    fontFamily: 'clashdisplay', 
    fontWeight: FontWeight.w600
  );
  static const TextStyle tileText = TextStyle(
    fontSize: 36,
    fontFamily: 'dm-sans',
    fontWeight: FontWeight.w600,
  );
}

class GameSetUpFonts {
  static const TextStyle yearLevelText = TextStyle(
    color: Colors.white, 
    fontSize: 22, fontWeight: 
    FontWeight.w900, 
    letterSpacing: 1.2
  );
  static const TextStyle attemptsAllowedText = TextStyle(
    color: Colors.blue, 
    fontSize: 12, 
    fontWeight: 
    FontWeight.bold, 
    letterSpacing: 1.5
  ); 
  static const TextStyle yearLabelBase = TextStyle(
    fontSize: 13,
    color: Colors.white54,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle yearLabelActive = TextStyle(
    fontSize: 13,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
    static const TextStyle attemptsInactiveText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white54,
  );
  static const TextStyle attemptsActiveText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF64B5F6),
  );
  static const IconData attemptsIcon = Icons.favorite;
  static const TextStyle closeButtonText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static const gameSettingsText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );
  static const playGameText = TextStyle(
    color: Color(0xFF0A0E17),
    fontSize: 18,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.1,
  );
  static const wordLengthText = TextStyle(
    color: Colors.blueGrey,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15 * 11,
  );
  static const numberOfLettersText = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
  static const lettersText = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
  );
}

class HomeFonts {
  static const disciplineText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
}