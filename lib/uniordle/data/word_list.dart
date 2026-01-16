import 'disciplines/engineering_words.dart';
import 'disciplines/medicine_words.dart';
import 'disciplines/cs_words.dart';
import 'disciplines/law_words.dart';

final Map<String, Map<int, List<String>>> categorizedWords = {
  'engineering': engineeringWords,
  'medicine': medicineWords,
  'cs': csWords,
  'law': lawWords,
};