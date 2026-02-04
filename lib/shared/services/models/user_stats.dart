import 'package:uniordle/features/home/data/major_data.dart';

class UserStats {

  static const int meritPerLevel = 100;

  final int streak;
  final int maxStreak;
  final int solved;
  final int lost;
  final int merit;
  final Map<int, int> guessDistribution;
  final List<String> unlockedIds;
  final List<String> masteredIds;
  final List<int> achievedMilestones;
  final Map<String, int> modeFrequency;
  final List<String> solvedWords;
  final List<Map<String, dynamic>> gameHistory;

  UserStats({
    required this.streak,
    required this.solved,
    required this.merit,
    this.maxStreak = 0,
    this.lost = 0,
    this.guessDistribution = const {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0},
    this.unlockedIds = const [],
    this.masteredIds = const [],
    this.achievedMilestones = const [],
    this.modeFrequency = const {},
    this.solvedWords = const [],
    this.gameHistory = const [],
  });

    UserStats copyWith({
    int? streak,
    int? maxStreak,
    int? solved,
    int? lost,
    int? merit,
    Map<int, int>? guessDistribution,
    List<String>? unlockedIds,
    List<String>? masteredIds,
    List<int>? achievedMilestones,
    Map<String, int>? modeFrequency,
    List<String>? solvedWords,
    List<Map<String, dynamic>>? gameHistory,
  }) {
    return UserStats(
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      solved: solved ?? this.solved,
      lost: lost ?? this.lost,
      merit: merit ?? this.merit,
      guessDistribution: guessDistribution ?? this.guessDistribution,
      unlockedIds: unlockedIds ?? this.unlockedIds,
      masteredIds: masteredIds ?? this.masteredIds,
      achievedMilestones: achievedMilestones ?? this.achievedMilestones,
      modeFrequency: modeFrequency ?? this.modeFrequency,
      solvedWords: solvedWords ?? this.solvedWords,
      gameHistory: gameHistory ?? this.gameHistory,
    );
  }

  int get totalGames => solved + lost;

  String get winPercentage {
    if (totalGames == 0) return "0%";
    return "${((solved / totalGames) * 100).toInt()}%";
  }
}

extension UserStatsProgress on UserStats {
  int get currentLevel => merit ~/ UserStats.meritPerLevel;
  int get nextLevel => currentLevel + 1;
  int get meritInCurrentLevel => merit % UserStats.meritPerLevel;
  double get levelProgress => (merit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble();
  int get progressPercentage => (levelProgress * 100).toInt();
  String get progressText => "$progressPercentage%";

  String get academicTitle {
    const titles = [
      "UNDERGRADUATE", "BACHELOR", "HONOURS", "MASTERS", 
      "DOCTORAL", "PROFESSOR", "DEAN", "CHANCELLOR",
    ];
    int index = (currentLevel ~/ 10).clamp(0, titles.length - 1);
    return titles[index];
  }

  static (int level, double progress) getPreviousState(int totalMerit, int gainedMerit) {
    int oldMerit = totalMerit - gainedMerit;
    return (oldMerit ~/ UserStats.meritPerLevel, (oldMerit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble());
  }

  int get standardPenalty {
    int rank = currentLevel ~/ 10;
    return 5 + (rank * 5); 
  }

  int get activePenalty {
    int rank = currentLevel ~/ 10;
    return 10 + (rank * 10);
  }
}

extension UserStatsRewards on UserStats {

  double get meritMultiplier {
    final double rankMultiplier = (currentLevel ~/ 10) * 0.10;
    
    final int additionalMajors = (unlockedIds.length - 1).clamp(0, 99);
    final double majorMultiplier = additionalMajors * 0.05;
    
    return 1.0 + majorMultiplier + rankMultiplier;
  }

  static ({int min, int max}) _calculateMeritBounds(int yearLevel, int wordLength) {
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);
    int lengthBonus = (wordLength == 6) ? 5 : (wordLength >= 7 ? 10 : 0);

    return (min: minBase + lengthBonus, max: maxBase + lengthBonus);
  }

  static ({String original, String boosted}) getMeritRange(UserStats stats, int yearLevel, int wordLength) {
    final bounds = _calculateMeritBounds(yearLevel, wordLength);
    final multiplier = stats.meritMultiplier;

    final int boostedMin = (bounds.min * multiplier).round();
    final int boostedMax = (bounds.max * multiplier).round();

    return (
      original: "${bounds.min}-${bounds.max}",
      boosted: "$boostedMin-$boostedMax"
    );
  }

  static int generateGainedMerit({
    required UserStats stats, 
    required int yearLevel, 
    required int wordLength, 
    required int attempts,
    required String majorId,
  }) {
    final bounds = _calculateMeritBounds(yearLevel, wordLength);
    
    double performanceWeight = (8 - attempts) / 7.0;
    
    performanceWeight = performanceWeight.clamp(0.0, 1.0);

    int baseMerit = bounds.min + ((bounds.max - bounds.min) * performanceWeight).round();

    double totalMerit = baseMerit * stats.meritMultiplier;

    final isMastered = stats.masteredMajorIds.contains(majorId);

    if (isMastered) {
      totalMerit *= 0.5;
    }
    
    return totalMerit.round();
  }
}

extension UserStatsUnlocks on UserStats {
  int get totalCreditsEarned => 1 + (currentLevel ~/ 5);
  int get creditsSpent => unlockedIds.length;
  int get availableCredits => totalCreditsEarned - creditsSpent;
  
  bool get hasCredits => availableCredits > 0;
  bool get hasAnyUnlock => unlockedIds.isNotEmpty;
  
  int get nextCreditAtLevel => (creditsSpent) * 5;
}

extension UserStatsMastery on UserStats {
  /// Returns a list of IDs for majors that are 100% complete
  List<String> get masteredMajorIds {
    return MajorsData.all.where((major) {
      final List<String> library = MajorsData.getAllWordsForMajor(major.id);
      if (library.isEmpty) return false;
      
      return library.every((word) => solvedWords.contains(word));
    }).map((m) => m.id).toList();
  }

  int get masteredCount => masteredMajorIds.length;

  ({int solved, double percent}) getMajorProgress(String majorId, int totalWords) {
    if (totalWords == 0) return (solved: 0, percent: 0.0);
    
    final List<String> library = MajorsData.getAllWordsForMajor(majorId);
    final int solvedCount = library.where((w) => solvedWords.contains(w)).length;
    
    return (
      solved: solvedCount,
      percent: (solvedCount / totalWords).clamp(0.0, 1.0)
    );
  }
}