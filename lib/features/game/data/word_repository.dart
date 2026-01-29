import 'package:uniordle/shared/exports/game_exports.dart';

import '../data/possible_word/possible_5_letters.dart';
import '../data/possible_word/possible_6_letters.dart';
import '../data/possible_word/possible_7_letters.dart';

class WordRepository {
  static List<String> getWordsForLength(int length) {
    switch (length) {
      case 5:
        return possible5Letters;
      case 6:
        return possible6Letters;
      case 7:
        return possible7Letters;
      default:
        return [];
    }
  }

  static bool isValidWord(String word) {
    int length = word.length;
    List<String> validList = getWordsForLength(length);
    return validList.contains(word.toUpperCase());
  }

  static String getNextWord({
  required String disciplineId,
  required int length,
  required List<String> userSolvedWords,
}) {
  final Map<int, List<String>>? disciplineMap = categorizedWords[disciplineId.toLowerCase()];
  final List<String> allWords = disciplineMap?[length] ?? [];
  
  if (allWords.isEmpty) return "ERROR";

  final List<String> unsolved = allWords
      .where((w) => !userSolvedWords.contains(w.toUpperCase()))
      .toList();

  final Random random = Random();
  final bool pickNew = random.nextDouble() < 0.8; 

  if (pickNew && unsolved.isNotEmpty) {
    return unsolved[random.nextInt(unsolved.length)];
  } else {
    return allWords[random.nextInt(allWords.length)];
  }
}
}