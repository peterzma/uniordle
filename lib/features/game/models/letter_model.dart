import 'package:uniordle/shared/exports/game_exports.dart';

enum LetterStatus { initial, notInWord, inWord, correct }

class Letter extends Equatable {
  final String val;
  final LetterStatus status;

  const Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => const Letter(val: '');

  Letter copyWith({String? val, LetterStatus? status}) {
    return Letter(val: val ?? this.val, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [val, status];
}
