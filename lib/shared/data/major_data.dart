import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/exports/word_lists_exports.dart';

class MajorsData {
  static List<String> getAllWordsForMajor(String id) {
    final Map<int, List<String>> wordMap =
        categorizedWords[id.toLowerCase()] ?? {};

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

      if (isAUnlocked && !isBUnlocked) return -1;
      if (!isAUnlocked && isBUnlocked) return 1;

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
    ),
    Major(
      id: 'cs',
      name: 'CS',
      icon: AppIcons.majorCS,
      totalWords: getWordCount(csWords),
    ),
    Major(
      id: 'medicine',
      name: 'Medicine',
      icon: AppIcons.majorMedicine,
      totalWords: getWordCount(medicineWords),
    ),
    Major(
      id: 'law',
      name: 'Law',
      icon: AppIcons.majorLaw,
      totalWords: getWordCount(lawWords),
    ),
    Major(
      id: 'psychology',
      name: 'Psychology',
      icon: AppIcons.majorPsychology,
      totalWords: getWordCount(psychologyWords),
    ),
    Major(
      id: 'arts',
      name: 'Arts',
      icon: AppIcons.majorArts,
      totalWords: getWordCount(artsWords),
    ),
    Major(
      id: 'humanities',
      name: 'Humanities',
      icon: AppIcons.majorHumanities,
      totalWords: getWordCount(humanitiesWords),
    ),
    Major(
      id: 'education',
      name: 'Education',
      icon: AppIcons.majorEducation,
      totalWords: getWordCount(educationWords),
    ),
    Major(
      id: 'maths',
      name: 'Maths',
      icon: AppIcons.majorMaths,
      totalWords: getWordCount(mathsWords),
    ),
    Major(
      id: 'music',
      name: 'Music',
      icon: AppIcons.majorMusic,
      totalWords: getWordCount(musicWords),
    ),
    Major(
      id: 'architecture',
      name: 'Architecture',
      icon: AppIcons.majorArchitecture,
      totalWords: getWordCount(architectureWords),
    ),
    Major(
      id: 'nursing',
      name: 'Nursing',
      icon: AppIcons.majorNursing,
      totalWords: getWordCount(nursingWords),
    ),
    Major(
      id: 'history',
      name: 'History',
      icon: AppIcons.majorHistory,
      totalWords: getWordCount(historyWords),
    ),
    Major(
      id: 'journalism',
      name: 'Journalism',
      icon: AppIcons.majorJournalism,
      totalWords: getWordCount(journalismWords),
    ),
    Major(
      id: 'astronomy',
      name: 'Astronomy',
      icon: AppIcons.majorAstronomy,
      totalWords: getWordCount(astronomyWords),
    ),
    Major(
      id: 'philosophy',
      name: 'Philosophy',
      icon: AppIcons.majorPhilosophy,
      totalWords: getWordCount(philosophyWords),
    ),
    Major(
      id: 'physics',
      name: 'Physics',
      icon: AppIcons.majorPhysics,
      totalWords: getWordCount(physicsWords),
    ),
    Major(
      id: 'chemistry',
      name: 'Chemistry',
      icon: AppIcons.majorChemistry,
      totalWords: getWordCount(chemistryWords),
    ),
    Major(
      id: 'biology',
      name: 'Biology',
      icon: AppIcons.majorBiology,
      totalWords: getWordCount(biologyWords),
    ),
    Major(
      id: 'economics',
      name: 'Economics',
      icon: AppIcons.majorEconomics,
      totalWords: getWordCount(economicsWords),
    ),
  ]..sort((a, b) => a.name.compareTo(b.name));
}
