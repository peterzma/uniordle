import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/exports/word_lists_exports.dart';

class MajorsData {
  static List<String> getAllWordsForMajor(String id) {
    // Get the map for this major (e.g., engineeringWords)
    final Map<int, List<String>> wordMap =
        categorizedWords[id.toLowerCase()] ?? {};

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
      color: AppColors.majorEngineering,
    ),
    Major(
      id: 'cs',
      name: 'CS',
      icon: AppIcons.majorCS,
      totalWords: getWordCount(csWords),
      tag: '${getWordCount(csWords)} WORDS',
      color: AppColors.majorCS,
    ),
    Major(
      id: 'medicine',
      name: 'Medicine',
      icon: AppIcons.majorMedicine,
      totalWords: getWordCount(medicineWords),
      tag: '${getWordCount(medicineWords)} WORDS',
      color: AppColors.majorMedicine,
    ),
    Major(
      id: 'law',
      name: 'Law',
      icon: AppIcons.majorLaw,
      totalWords: getWordCount(lawWords),
      tag: '${getWordCount(lawWords)} WORDS',
      color: AppColors.majorLaw,
    ),
    Major(
      id: 'psychology',
      name: 'Psychology',
      icon: AppIcons.majorPsychology,
      totalWords: getWordCount(psychologyWords),
      tag: '${getWordCount(psychologyWords)} WORDS',
      color: AppColors.majorPsychology,
    ),
    Major(
      id: 'arts',
      name: 'Arts',
      icon: AppIcons.majorArts,
      totalWords: getWordCount(artsWords),
      tag: '${getWordCount(artsWords)} WORDS',
      color: AppColors.majorArts,
    ),
    Major(
      id: 'humanities',
      name: 'Humanities',
      icon: AppIcons.majorHumanities,
      totalWords: getWordCount(humanitiesWords),
      tag: '${getWordCount(humanitiesWords)} WORDS',
      color: AppColors.majorHumanities,
    ),
    Major(
      id: 'education',
      name: 'Education',
      icon: AppIcons.majorEducation,
      totalWords: getWordCount(educationWords),
      tag: '${getWordCount(educationWords)} WORDS',
      color: AppColors.majorEducation,
    ),
    Major(
      id: 'maths',
      name: 'Maths',
      icon: AppIcons.majorMaths,
      totalWords: getWordCount(mathsWords),
      tag: '${getWordCount(mathsWords)} WORDS',
      color: AppColors.majorMaths,
    ),
    Major(
      id: 'music',
      name: 'Music',
      icon: AppIcons.majorMusic,
      totalWords: getWordCount(musicWords),
      tag: '${getWordCount(musicWords)} WORDS',
      color: AppColors.majorMusic,
    ),
    Major(
      id: 'architecture',
      name: 'Architecture',
      icon: AppIcons.majorArchitecture,
      totalWords: getWordCount(architectureWords),
      tag: '${getWordCount(architectureWords)} WORDS',
      color: AppColors.majorArchitecture,
    ),
    Major(
      id: 'nursing',
      name: 'Nursing',
      icon: AppIcons.majorNursing,
      totalWords: getWordCount(nursingWords),
      tag: '${getWordCount(nursingWords)} WORDS',
      color: AppColors.majorNursing,
    ),
    Major(
      id: 'history',
      name: 'History',
      icon: AppIcons.majorHistory,
      totalWords: getWordCount(historyWords),
      tag: '${getWordCount(historyWords)} WORDS',
      color: AppColors.majorHistory,
    ),
    Major(
      id: 'journalism',
      name: 'Journalism',
      icon: AppIcons.majorJournalism,
      totalWords: getWordCount(journalismWords),
      tag: '${getWordCount(journalismWords)} WORDS',
      color: AppColors.majorJournalism,
    ),
    Major(
      id: 'astronomy',
      name: 'Astronomy',
      icon: AppIcons.majorAstronomy,
      totalWords: getWordCount(astronomyWords),
      tag: '${getWordCount(astronomyWords)} WORDS',
      color: AppColors.majorAstronomy,
    ),
    Major(
      id: 'philosophy',
      name: 'Philosophy',
      icon: AppIcons.majorPhilosophy,
      totalWords: getWordCount(philosophyWords),
      tag: '${getWordCount(philosophyWords)} WORDS',
      color: AppColors.majorPhilosophy,
    ),
    Major(
      id: 'physics',
      name: 'Physics',
      icon: AppIcons.majorPhysics,
      totalWords: getWordCount(physicsWords),
      tag: '${getWordCount(physicsWords)} WORDS',
      color: AppColors.majorPhysics,
    ),
    Major(
      id: 'chemistry',
      name: 'Chemistry',
      icon: AppIcons.majorChemistry,
      totalWords: getWordCount(chemistryWords),
      tag: '${getWordCount(chemistryWords)} WORDS',
      color: AppColors.majorChemistry,
    ),
    Major(
      id: 'biology',
      name: 'Biology',
      icon: AppIcons.majorBiology,
      totalWords: getWordCount(biologyWords),
      tag: '${getWordCount(biologyWords)} WORDS',
      color: AppColors.majorBiology,
    ),
    Major(
      id: 'economics',
      name: 'Economics',
      icon: AppIcons.majorEconomics,
      totalWords: getWordCount(economicsWords),
      tag: '${getWordCount(economicsWords)} WORDS',
      color: AppColors.majorEconomics,
    ),
  ]..sort((a, b) => a.name.compareTo(b.name));
}
