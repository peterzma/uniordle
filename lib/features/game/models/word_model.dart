import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:equatable/equatable.dart';

/// Represents a guessed word in the game
/// 
/// A word consists of a fixed length list of [Letter] objects
class Word extends Equatable {
  const Word({
    required this.letters
  });

  /// Creates a word from string
  /// 
  /// Each character becomes a [Letter] with an initial status
  factory Word.fromString(String word) =>
    Word(
      letters: word
      .split('')
      .map((e) => Letter(val: e))
      .toList()
    );

  final List<Letter> letters;
  /// Returns the word as a single string
  String get wordString => letters.map((e) => e.val).join();

  /// Add letter to first enmpty position
  void addLetter(String val) {
    final currentIndex = letters.indexWhere((e) => e.val.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val: val);
    }
  }

  /// Removes most recent added letter
  void removeLetter() {
    final recentLetterIndex = letters.lastIndexWhere((e) => e.val.isNotEmpty);
    if (recentLetterIndex != -1) {
      letters[recentLetterIndex] = Letter.empty();
    }
  }

  @override
  List<Object?> get props => [letters];
}