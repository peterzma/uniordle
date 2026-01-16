import 'difficulty.dart';

class GameSettings {
  final int wordLength;
  final Difficulty difficulty;

  const GameSettings({
    required this.wordLength,
    required this.difficulty,
  });

  GameSettings copyWith({
    int? wordLength,
    Difficulty? difficulty,
  }) {
    return GameSettings(
      wordLength: wordLength ?? this.wordLength,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
