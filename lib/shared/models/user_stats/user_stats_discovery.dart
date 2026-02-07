part of 'user_stats.dart';

extension UserStatsUnlocks on UserStats {
  int get totalCreditsEarned => 1 + (currentLevel ~/ 5);
  int get creditsSpent => unlockedIds.length + extraBoosts;
  int get availableCredits => totalCreditsEarned - creditsSpent;

  bool get hasCredits => availableCredits > 0;
  bool get hasAnyUnlock => unlockedIds.isNotEmpty;

  int get nextCreditAtLevel => (creditsSpent) * 5;
}

extension UserStatsMastery on UserStats {
  /// Returns a list of IDs for majors that are 100% complete
  List<String> get masteredMajorIds {
    // // TEST MODE TO MASTER ALL MAJORS
    // return MajorsData.all.map((m) => m.id).toList();
    return MajorsData.all
        .where((major) {
          final List<String> library = MajorsData.getAllWordsForMajor(major.id);
          if (library.isEmpty) return false;

          return library.every((word) => solvedWords.contains(word));
        })
        .map((m) => m.id)
        .toList();
  }

  int get masteredCount => masteredMajorIds.length;

  ({int solved, double percent}) getMajorProgress(
    String majorId,
    int totalWords,
  ) {
    if (totalWords == 0) return (solved: 0, percent: 0.0);

    final List<String> library = MajorsData.getAllWordsForMajor(majorId);
    final int solvedCount = library
        .where((w) => solvedWords.contains(w))
        .length;

    // // TEST MODE FORCE 100% PROGRESS FOR TESTING
    // return (solved: totalWords, percent: 1.0);

    return (
      solved: solvedCount,
      percent: (solvedCount / totalWords).clamp(0.0, 1.0),
    );
  }
}
