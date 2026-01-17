import 'word_lists/engineering_words.dart';
import 'word_lists/medicine_words.dart';
import 'word_lists/cs_words.dart';
import 'word_lists/law_words.dart';
import 'word_lists/psychology_words.dart';
import 'word_lists/arts_words.dart';
import 'word_lists/business_words.dart';
import 'word_lists/humanities_words.dart';
import 'word_lists/education_words.dart';
import 'word_lists/maths_words.dart';
import 'word_lists/music_words.dart';
import 'word_lists/science_words.dart';
import 'word_lists/design_words.dart';
import 'word_lists/architecture_words.dart';


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
};
