import 'package:flutter/material.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/home/models/major.dart';
import 'package:uniordle/shared/exports/word_lists_exports.dart';
import 'package:uniordle/features/game/data/word_list.dart';

class MajorsData {

  static List<String> getAllWordsForMajor(String id) {
    // Get the map for this major (e.g., engineeringWords)
    final Map<int, List<String>> wordMap = categorizedWords[id.toLowerCase()] ?? {};
    
    // Flatten all values (List of strings for 5, 6, 7 letters) into one list
    return wordMap.values
        .expand((list) => list)
        .map((word) => word.toUpperCase())
        .toList();
  }

  static int getWordCount(Map<int, List<String>> wordMap) {
    return wordMap.values.fold(0, (sum, list) => sum + list.length);
  }

  static List<Major> getSortedMajors(List<String> unlockedIds) {
    List<Major> sortedList = List.from(all);

    sortedList.sort((a, b) {
      bool isAUnlocked = unlockedIds.contains(a.id);
      bool isBUnlocked = unlockedIds.contains(b.id);

      // Sort by "Lockedness"
      if (isAUnlocked && !isBUnlocked) return -1;
      if (!isAUnlocked && isBUnlocked) return 1;

      // Sort Alphabetically
      return a.name.compareTo(b.name);
    });

    return sortedList;
  }

  static final List<Major> all = [
  Major(
    id: 'engineering',
    name: 'Engineering',
    icon: AppIcons.majorEngineering,
    totalWords: getWordCount(engineeringWords),
    tag: '${getWordCount(engineeringWords)} WORDS', 
    color: const Color(0xFF00BCD4), // Bright Cyan
  ),
  Major(
    id: 'cs',
    name: 'CS',
    icon: AppIcons.majorCS,
    totalWords: getWordCount(csWords),
    tag: '${getWordCount(csWords)} WORDS',
    color: const Color(0xFF448AFF), // Electric Blue
  ),
  Major(
    id: 'medicine',
    name: 'Medicine',
    icon: AppIcons.majorMedicine,
    totalWords: getWordCount(medicineWords),
    tag: '${getWordCount(medicineWords)} WORDS',
    color: const Color(0xFFFF4081), // Bright Pink
  ),
  Major(
    id: 'law',
    name: 'Law',
    icon: AppIcons.majorLaw,
    totalWords: getWordCount(lawWords),
    tag: '${getWordCount(lawWords)} WORDS',
    color: const Color(0xFFFFAB40), // Bright Amber/Orange
  ),
  Major(
    id: 'psychology',
    name: 'Psychology',
    icon: AppIcons.majorPsychology,
    totalWords: getWordCount(psychologyWords),
    tag: '${getWordCount(psychologyWords)} WORDS',
    color: const Color(0xFFE040FB), // Vivid Orchid
  ),
  Major(
    id: 'arts',
    name: 'Arts',
    icon: AppIcons.majorArts,
    totalWords: getWordCount(artsWords),
    tag: '${getWordCount(artsWords)} WORDS',
    color: const Color(0xFFFF5252), // Bright Coral/Red
  ),
  Major(
    id: 'humanities',
    name: 'Humanities',
    icon: AppIcons.majorHumanities,
    totalWords: getWordCount(humanitiesWords),
    tag: '${getWordCount(humanitiesWords)} WORDS',
    color: const Color(0xFFFFD740), // Sunflower Yellow
  ),
  Major(
    id: 'education',
    name: 'Education',
    icon: AppIcons.majorEducation,
    totalWords: getWordCount(educationWords),
    tag: '${getWordCount(educationWords)} WORDS',
    color: const Color(0xFF40C4FF), // Light Sky Blue
  ),
  Major(
    id: 'maths',
    name: 'Maths',
    icon: AppIcons.majorMaths,
    totalWords: getWordCount(mathsWords),
    tag: '${getWordCount(mathsWords)} WORDS',
    color: const Color(0xFF7C4DFF), // Deep Purple Accent
  ),
  Major(
    id: 'music',
    name: 'Music',
    icon: AppIcons.majorMusic,
    totalWords: getWordCount(musicWords),
    tag: '${getWordCount(musicWords)} WORDS',
    color: const Color(0xFFEEFF41), // Neon Lime
  ),
  Major(
    id: 'architecture',
    name: 'Architecture',
    icon: AppIcons.majorArchitecture,
    totalWords: getWordCount(architectureWords),
    tag: '${getWordCount(architectureWords)} WORDS',
    color: const Color(0xFF1DE9B6), // Bright Aquamarine
  ),
  Major(
    id: 'nursing',
    name: 'Nursing',
    icon: AppIcons.majorNursing,
    totalWords: getWordCount(nursingWords),
    tag: '${getWordCount(nursingWords)} WORDS',
    color: const Color(0xFFFF6E40), // Bright Sunset Orange
  ),
  Major(
    id: 'history',
    name: 'History',
    icon: AppIcons.majorHistory,
    totalWords: getWordCount(historyWords),
    tag: '${getWordCount(historyWords)} WORDS',
    color: const Color(0xFFA1887F), // Light Terracotta
  ),
  Major(
    id: 'journalism',
    name: 'Journalism',
    icon: AppIcons.majorJournalism,
    totalWords: getWordCount(journalismWords),
    tag: '${getWordCount(journalismWords)} WORDS',
    color: const Color(0xFF90A4AE), // Cool Steel Blue
  ),
  Major(
    id: 'astronomy',
    name: 'Astronomy',
    icon: AppIcons.majorAstronomy,
    totalWords: getWordCount(astronomyWords),
    tag: '${getWordCount(astronomyWords)} WORDS',
    color: const Color(0xFF536DFE), // Indigo Accent
  ),
  Major(
    id: 'philosophy',
    name: 'Philosophy',
    icon: AppIcons.majorPhilosophy,
    totalWords: getWordCount(philosophyWords),
    tag: '${getWordCount(philosophyWords)} WORDS',
    color: const Color(0xFFE0E0E0), // Cloud Grey
  ),
  Major(
    id: 'physics',
    name: 'Physics',
    icon: AppIcons.majorPhysics,
    totalWords: getWordCount(physicsWords),
    tag: '${getWordCount(physicsWords)} WORDS',
    color: const Color(0xFFB388FF), // Lavender Pro
  ),
  Major(
    id: 'chemistry',
    name: 'Chemistry',
    icon: AppIcons.majorChemistry,
    totalWords: getWordCount(chemistryWords),
    tag: '${getWordCount(chemistryWords)} WORDS',
    color: const Color(0xFF69F0AE), // Spring Green
  ),
  Major(
    id: 'biology',
    name: 'Biology',
    icon: AppIcons.majorBiology,
    totalWords: getWordCount(biologyWords),
    tag: '${getWordCount(biologyWords)} WORDS',
    color: const Color(0xFFB2FF59), // Electric Lime
  ),
  Major(
    id: 'economics',
    name: 'Economics',
    icon: AppIcons.majorEconomics,
    totalWords: getWordCount(economicsWords),
    tag: '${getWordCount(economicsWords)} WORDS',
    color: const Color(0xFF00E676), // Bright Emerald
  )]..sort((a, b) => a.name.compareTo(b.name));

}