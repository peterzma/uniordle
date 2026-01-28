import 'dart:convert';
import 'dart:math';
import 'package:uniordle/shared/exports/profile_exports.dart';

class StatsManager {
  static final StatsManager _instance = StatsManager._internal();
  factory StatsManager() => _instance;
  StatsManager._internal();

  late SharedPreferences _prefs;
  final ValueNotifier<UserStats> statsNotifier = ValueNotifier(UserStats(streak: 0, solved: 0, merit: 0));
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    final distString = _prefs.getString('stat_dist') ?? '{}';
    final Map<String, dynamic> decodedDist = jsonDecode(distString);
    
    final Map<int, int> distribution = {
      for (var e in decodedDist.entries) int.parse(e.key): e.value as int
    };

    final Map<int, int> fullDistribution = {
      for (int i = 1; i <= 8; i++) i: distribution[i] ?? 0
    };

    statsNotifier.value = UserStats(
      streak: _prefs.getInt('stat_streak') ?? 0,
      maxStreak: _prefs.getInt('stat_max_streak') ?? 0,
      solved: _prefs.getInt('stat_solved') ?? 0,
      lost: _prefs.getInt('stat_lost') ?? 0,
      merit: _prefs.getInt('stat_merit') ?? 0,
      guessDistribution: fullDistribution,
    );
  }

  Future<int> recordWin({required int yearLevel, required int wordLength, required int attempts}) async {
    final current = statsNotifier.value;

    final int gainedMerit = UserStatsExtension.generateGainedMerit(yearLevel, wordLength);

    final newMerit = current.merit + gainedMerit;
    final newStreak = current.streak + 1;
    final newMaxStreak = max(newStreak, current.maxStreak);
    final newDist = Map<int, int>.from(current.guessDistribution);
    newDist[attempts] = (newDist[attempts] ?? 0) + 1;
    
    await _prefs.setInt('stat_merit', newMerit);
    await _prefs.setInt('stat_streak', newStreak);
    await _prefs.setInt('stat_max_streak', newMaxStreak);
    await _prefs.setString('stat_dist', jsonEncode(newDist.map((k, v) => MapEntry(k.toString(), v))));

    statsNotifier.value = UserStats(
      streak: newStreak,
      maxStreak: newMaxStreak,
      solved: current.solved + 1,
      lost: current.lost,
      merit: newMerit,
      guessDistribution: newDist,
    );

    return gainedMerit;
  }

  Future<void> recordLoss() async {
    await _applyPenalty(UserStatsExtension.penaltyAmount);
  }

  Future<void> recordAbandonment() async {
    await _applyPenalty(UserStatsExtension.penaltyAmount);
  }

  Future<void> _applyPenalty(int amount) async {
    final current = statsNotifier.value;
    final newLost = current.lost + 1;
    final newMerit = (current.merit - amount).clamp(0, 999999);

    await _prefs.setInt('stat_streak', 0);
    await _prefs.setInt('stat_lost', newLost);
    await _prefs.setInt('stat_merit', newMerit);

    statsNotifier.value = UserStats(
      streak: 0,
      maxStreak: current.maxStreak,
      solved: current.solved,
      lost: newLost,
      merit: newMerit,
      guessDistribution: current.guessDistribution,
    );
  }
}

final statsManager = StatsManager();