import 'package:uniordle/shared/data/major_data.dart';

part 'user_stats_progression.dart';
part 'user_stats_rewards.dart';
part 'user_stats_discovery.dart';

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
    this.guessDistribution = const {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
    },
    this.unlockedIds = const [],
    this.masteredIds = const [],
    this.achievedMilestones = const [],
    this.modeFrequency = const {},
    this.solvedWords = const [],
    this.gameHistory = const [],
    int? extraBoosts,
  }) : extraBoosts = extraBoosts ?? 0;

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
