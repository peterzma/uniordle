import 'package:equatable/equatable.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';

/// Represents a single letter in the game
/// 
/// Tracks the letter character and its checked status
enum LetterStatus { 
  initial, 
  notInWord, 
  inWord, 
  correct 
}

/// A letter with its value and status
/// 
/// Provides methods for copying with updated values and
/// getting UI colours based on states
class Letter extends Equatable {
  const Letter({
    required this.val,
    this.status = LetterStatus.initial,
  });

  /// Creates an empty letter used for unfilled board positions
  factory Letter.empty() => const Letter(val: '');

  /// Character value of the letter
  final String val;

  /// Current status of letter
  final LetterStatus status;

  /// Background colour for the tile based on [status]
  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial:
        return AppColors.tileBackground;
      case LetterStatus.notInWord:
        return AppColors.notInWordColor;
      case LetterStatus.inWord:
        return AppColors.inWordColor;
      case LetterStatus.correct:
        return AppColors.correctColor;
    }
  }

  Color get borderColor {
    switch (status) {
      case LetterStatus.initial:
        return AppColors.tileBackground;
      default:
      return AppColors.tileBackground;
    }
  }

  /// Returns a new [Letter] instance with updated values
  Letter copyWith({
    String? val,
    LetterStatus? status,
  }) {
    return Letter(
      val: val ?? this.val,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [val, status];
}