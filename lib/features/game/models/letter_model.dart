import 'package:uniordle/shared/exports/game_exports.dart';

enum LetterStatus { 
  initial, 
  notInWord, 
  inWord, 
  correct 
}

class Letter extends Equatable {
  const Letter({
    required this.val,
    this.status = LetterStatus.initial,
  });

  factory Letter.empty() => const Letter(val: '');

  final String val;

  final LetterStatus status;

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial:
        return AppColors.gameTiles;
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
        return val.isNotEmpty ? AppColors.outline : AppColors.surfaceVariant;
      case LetterStatus.notInWord:
      case LetterStatus.inWord:
      case LetterStatus.correct:
        return backgroundColor; 
    }
  }

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