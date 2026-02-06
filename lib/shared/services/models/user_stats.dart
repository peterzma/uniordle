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
  final int extraBoosts;

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
    int? extraBoosts,
  }): extraBoosts = extraBoosts ?? 0;

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
    int? extraBoosts,
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
      extraBoosts: extraBoosts ?? this.extraBoosts,
    );
  }

  int get totalGames => solved + lost;

  String get winPercentage {
    if (totalGames == 0) return "0%";
    return "${((solved / totalGames) * 100).toInt()}%";
  }
}

extension UserStatsProgress on UserStats {
  // int get currentLevel => merit ~/ UserStats.meritPerLevel;
  int get currentLevel => 125;
  int get nextLevel => currentLevel + 1;
  int get meritInCurrentLevel => merit % UserStats.meritPerLevel;
  double get levelProgress => (merit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble();
  int get progressPercentage => (levelProgress * 100).toInt();
  String get progressText => "$progressPercentage%";

  String get academicTitle {
    const titles = [
      "UNDERGRADUATE", // 0-9
      "BACHELOR",      // 10-19
      "MASTER",        // 20-29
      "DOCTORATE",     // 30-39
      "PROFESSOR",     // 40-49
      "FELLOW",        // 50-59
      "DEAN",          // 60-69
      "PROVOST",       // 70-79
      "RECTOR",        // 80-89
      "CHANCELLOR",    // 90-99
      "THE ORACLE",    // 100+
    ];

    int index = (currentLevel ~/ 10).clamp(0, titles.length - 1);
    return titles[index];
  }

  static (int level, double progress) getPreviousState(int totalMerit, int gainedMerit) {
    int oldMerit = totalMerit - gainedMerit;
    return (oldMerit ~/ UserStats.meritPerLevel, (oldMerit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble());
  }

  int get effectiveRank => (currentLevel ~/ 10).clamp(0, 10);

  int get standardPenalty {
    return (effectiveRank * 5); 
  }

  int get activePenalty {
    return (effectiveRank * 10);
  }
}

extension UserStatsRewards on UserStats {
  double get masteryBonusValue => masteredCount >= MajorsData.all.length ? 2.0 : 0.0;

  double get summitBonusValue => currentLevel >= 100 ? 1.0 : 0.0;

  double get majorMultiplier {
    final int unlockedCount = unlockedIds.length;
    double baseMultiplier = 0.0;

    if (unlockedCount >= 20) {
      baseMultiplier = 1.0;
    } else if (unlockedCount == 19) {
      baseMultiplier = 0.90;
    } else {
      baseMultiplier = unlockedCount * 0.05;
    }

    final double researchBonus = extraBoosts * 0.10;

    return baseMultiplier + researchBonus;
  }

  double get meritMultiplier {
    // Rank Bonus: +10% for every 10 levels

    final int effectiveLevelForBonus = currentLevel.clamp(0, 100);

    final double rankMultiplier = (effectiveLevelForBonus ~/ 10) * 0.10;
    
    // Major Bonus: 200%
    final double majorBonus = majorMultiplier;
    
    // Base is 1.0 (100%)
    return 1.0 + majorBonus + rankMultiplier + summitBonusValue + masteryBonusValue;
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

    final bool isMastered = stats.masteredMajorIds.contains(majorId);
    final bool hasFinishedAll = stats.masteredCount >= MajorsData.all.length;

    if (isMastered && !hasFinishedAll) {
      totalMerit *= 0.5;
    }
    
    return totalMerit.round();
  }

  static ({int min, int max}) calculateReducedBounds(int min, int max) {
    return (
      min: min ~/ 2,
      max: max ~/ 2,
    );
  }

  static String formatReducedRange(String boostedRange) {
    final parts = boostedRange.split('-');
    if (parts.length != 2) return boostedRange;
    
    final min = (int.tryParse(parts[0]) ?? 0) ~/ 2;
    final max = (int.tryParse(parts[1]) ?? 0) ~/ 2;
    
    return "$min-$max";
  }
}

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
    // ==========================================
    // TEST MODE: Uncomment to Master All Majors
    return MajorsData.all.map((m) => m.id).toList();
    // ==========================================

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