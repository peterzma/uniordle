part of 'user_stats.dart';

extension UserStatsProgress on UserStats {
  int get currentLevel => merit ~/ UserStats.meritPerLevel;
  int get nextLevel => currentLevel + 1;
  int get meritInCurrentLevel => merit % UserStats.meritPerLevel;
  double get levelProgress =>
      (merit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble();
  int get progressPercentage => (levelProgress * 100).toInt();
  String get progressText => "$progressPercentage%";

  String get academicTitle {
    const titles = [
      "UNDERGRADUATE", // 0-9
      "BACHELOR", // 10-19
      "MASTER", // 20-29
      "DOCTORATE", // 30-39
      "PROFESSOR", // 40-49
      "FELLOW", // 50-59
      "DEAN", // 60-69
      "PROVOST", // 70-79
      "RECTOR", // 80-89
      "CHANCELLOR", // 90-99
      "THE ORACLE", // 100+
    ];

    int index = (currentLevel ~/ 10).clamp(0, titles.length - 1);
    return titles[index];
  }

  static (int level, double progress) getPreviousState(
    int totalMerit,
    int gainedMerit,
  ) {
    int oldMerit = totalMerit - gainedMerit;
    return (
      oldMerit ~/ UserStats.meritPerLevel,
      (oldMerit % UserStats.meritPerLevel) / UserStats.meritPerLevel.toDouble(),
    );
  }

  int get effectiveRank => (currentLevel ~/ 10);

  int get standardPenalty {
    return (effectiveRank * 5);
  }

  int get activePenalty {
    return (effectiveRank * 20);
  }
}
