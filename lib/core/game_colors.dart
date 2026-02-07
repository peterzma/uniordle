import 'package:flutter/material.dart';

class GameColors extends ThemeExtension<GameColors> {
  final Color? correct;
  final Color? inWord;
  final Color? notInWord;

  const GameColors({
    required this.correct,
    required this.inWord,
    required this.notInWord,
  });

  @override
  GameColors copyWith({Color? correct, Color? inWord, Color? notInWord}) {
    return GameColors(
      correct: correct ?? this.correct,
      inWord: inWord ?? this.inWord,
      notInWord: notInWord ?? this.notInWord,
    );
  }

  @override
  GameColors lerp(ThemeExtension<GameColors>? other, double t) {
    if (other is! GameColors) return this;
    return GameColors(
      correct: Color.lerp(correct, other.correct, t),
      inWord: Color.lerp(inWord, other.inWord, t),
      notInWord: Color.lerp(notInWord, other.notInWord, t),
    );
  }
}
