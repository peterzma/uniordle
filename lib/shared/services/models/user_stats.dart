import 'dart:math';

class UserStats {

  static const int meritPerLevel = 100;
  static const int penaltyAmount = 10;

  final int streak;
  final int maxStreak;
  final int solved;
  final int lost;
  final int merit;
  final Map<int, int> guessDistribution;
  final List<String> unlockedIds;
  final List<int> achievedMilestones;

  UserStats({
    required this.streak,
    required this.solved,
    required this.merit,
    this.maxStreak = 0,
    this.lost = 0,
    this.guessDistribution = const {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0},
    this.unlockedIds = const [],
    this.achievedMilestones = const [],
  });

    UserStats copyWith({
    int? streak,
    int? maxStreak,
    int? solved,
    int? lost,
    int? merit,
    Map<int, int>? guessDistribution,
    List<String>? unlockedIds,
    List<int>? achievedMilestones,
  }) {
    return UserStats(
      streak: streak ?? this.streak,
      maxStreak: maxStreak ?? this.maxStreak,
      solved: solved ?? this.solved,
      lost: lost ?? this.lost,
      merit: merit ?? this.merit,
      guessDistribution: guessDistribution ?? this.guessDistribution,
      unlockedIds: unlockedIds ?? this.unlockedIds,
      achievedMilestones: achievedMilestones ?? this.achievedMilestones,
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

  int get activePenalty {
    int rank = currentLevel ~/ 10;
    return UserStats.penaltyAmount + (rank * 5);
  }
}

extension UserStatsRewards on UserStats {

  double get meritMultiplier {
    // 5% bonus per
    final double rankMultiplier = (currentLevel ~/ 10) * 0.05;
    
    // 10% bonus per
    final double disciplineMultiplier = unlockedIds.length * 0.10;
    
    return 1.0 + disciplineMultiplier + rankMultiplier;
  }

  static ({int min, int max}) _calculateMeritBounds(int yearLevel, int wordLength) {
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);
    int lengthBonus = (wordLength == 6) ? 5 : (wordLength >= 7 ? 15 : 0);

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

  static int generateGainedMerit(UserStats stats, int yearLevel, int wordLength) {
    final bounds = _calculateMeritBounds(yearLevel, wordLength);
    final random = Random();
    int baseMerit = bounds.min + random.nextInt(bounds.max - bounds.min + 1);
    
    return (baseMerit * stats.meritMultiplier).round();
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