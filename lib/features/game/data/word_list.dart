import 'package:uniordle/shared/exports/word_lists_exports.dart';

final Map<String, Map<int, List<String>>> categorizedWords = {
  'engineering': engineeringWords,
  'medicine': medicineWords,
  'cs': csWords,
  'law': lawWords,
  'psychology': psychologyWords,
  'arts': artsWords,
  'business': businessWords,
  'humanities': humanitiesWords,
  'education': educationWords,
  'maths': mathsWords,
  'music': musicWords,
  'science': scienceWords,
  'design': designWords,
  'architecture': architectureWords,
  // TODO: add the new majors into here instead of importing each
};
