class UserStats {
  final int streak;
  final int maxStreak;
  final int solved;
  final int lost;
  final int xp;
  final Map<int, int> guessDistribution;

  UserStats({
    required this.streak,
    required this.solved,
    required this.xp,
    this.maxStreak = 0, // Default to 0
    this.lost = 0,      // Default to 0
    this.guessDistribution = const {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0},
  });

  int get totalGames => solved + lost;
  String get winPercentage => totalGames == 0 ? "0%" : "${((solved / totalGames) * 100).toInt()}%";
}

extension UserStatsExtension on UserStats {
  static const int xpPerLevel = 100;

  static int calculateGainedXP(int yearLevel, int wordLength) {
    return 20 + (yearLevel * 5) + ((wordLength - 5) * 5);
  }

  int get currentLevel => xp ~/ xpPerLevel;
  int get nextLevel => currentLevel + 1;
  double get levelProgress => (xp % xpPerLevel) / xpPerLevel;
  int get xpInCurrentLevel => xp % xpPerLevel;
  
  String get progressText => "$xpInCurrentLevel/$xpPerLevel XP";
}