import 'dart:math';

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
  static const int creditsPerLevel = 100;

  static int calculateGainedXP(int yearLevel, int wordLength) {
    final random = Random();
    
    //
    // Year 1: 15-25 | Year 2: 20-30 | Year 3: 25-35 | Postgrad: 30-45
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);

    // 5: +0 | 6: +3 | 7: +7
    int lengthBonus = 0;
    if (wordLength == 6) lengthBonus = 5;
    if (wordLength == 7) lengthBonus = 15;

    int reward = minBase + random.nextInt(maxBase - minBase + 1) + lengthBonus;

    return reward;
  }

  static String getCreditRange(int yearLevel, int wordLength) {
    int minBase = 10 + (yearLevel * 5);
    int maxBase = 20 + (yearLevel * 6);
    int lengthBonus = 0;
    if (wordLength == 6) lengthBonus = 5;
    if (wordLength == 7) lengthBonus = 15;

    return "${minBase + lengthBonus} - ${maxBase + lengthBonus}";
  }

  int get currentLevel => xp ~/ creditsPerLevel;
  int get nextLevel => currentLevel + 1;
  double get levelProgress => (xp % creditsPerLevel) / creditsPerLevel;
  int get xpInCurrentLevel => xp % creditsPerLevel;
  
  String get progressText => "$xpInCurrentLevel/$creditsPerLevel CREDITS";

  String get academicTitle => getAcademicTitle(currentLevel);

  String getAcademicTitle(int level) {
    const titles = [
      "UNDERGRADUATE", // 0-9
      "BACHELOR",      // 10-19
      "HONOURS",       // 20-29
      "MASTERS",       // 30-39
      "DOCTORAL",      // 40-49
      "PROFESSOR",     // 50-59
      "DEAN",          // 60+
      "CHANCELLOR",    // 70+
    ];
    
    // Calculate index: level 15 ~/ 10 = index 1
    int index = level ~/ 10;
    
    // Ensure we don't go out of bounds if level is 70+
    if (index >= titles.length) index = titles.length - 1;
    
    return titles[index];
  }
}