class UserStats {
  final int streak;
  final int solved;

  UserStats({required this.streak, required this.solved});
}

extension UserStatsExtension on UserStats {
  static const int wordsPerLevel = 2;

  int get currentLevel => solved ~/ wordsPerLevel;
  int get nextLevel => currentLevel + 1;
  double get levelProgress => (solved % wordsPerLevel) / wordsPerLevel;
  int get solvedInCurrentLevel => solved % wordsPerLevel;
  
  String get progressText => "$solvedInCurrentLevel/$wordsPerLevel SOLVES TO LEVEL $nextLevel";
}