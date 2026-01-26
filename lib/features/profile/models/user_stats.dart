class UserStats {
  final int streak;
  final int solved;
  final int xp;

  UserStats({
    required this.streak, 
    required this.solved, 
    required this.xp,
  });
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