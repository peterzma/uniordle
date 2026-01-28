import 'dart:convert';
import 'package:uniordle/shared/exports/profile_exports.dart';

class StatsManager {
  static final StatsManager _instance = StatsManager._internal();
  factory StatsManager() => _instance;
  StatsManager._internal();

  late SharedPreferences _prefs;
  
  final ValueNotifier<UserStats> statsNotifier = ValueNotifier(
    UserStats(
      streak: 0, 
      maxStreak: 0, 
      solved: 0, 
      lost: 0, 
      xp: 0, 
      guessDistribution: {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0},
    )
  );

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
      xp: _prefs.getInt('stat_xp') ?? 0,
      guessDistribution: fullDistribution,
    );
  }

  Future<void> recordWin({required int yearLevel, required int wordLength, required int attempts}) async {
    final current = statsNotifier.value;
    final int gainedCredits = UserStatsExtension.calculateGainedXP(yearLevel, wordLength);

    final newSolved = current.solved + 1;
    final newXP = current.xp + gainedCredits;
    final newStreak = current.streak + 1;
    final newMaxStreak = newStreak > current.maxStreak ? newStreak : current.maxStreak;
    
    final newDist = Map<int, int>.from(current.guessDistribution);
    newDist[attempts] = (newDist[attempts] ?? 0) + 1;

    await _prefs.setInt('stat_solved', newSolved);
    await _prefs.setInt('stat_streak', newStreak);
    await _prefs.setInt('stat_max_streak', newMaxStreak);
    await _prefs.setInt('stat_xp', newXP);
    await _prefs.setString('stat_dist', jsonEncode(newDist.map((k, v) => MapEntry(k.toString(), v))));

    statsNotifier.value = UserStats(
      streak: newStreak,
      maxStreak: newMaxStreak,
      solved: newSolved,
      lost: current.lost,
      xp: newXP,
      guessDistribution: newDist,
    );
  }

  Future<void> recordLoss() async {
    final current = statsNotifier.value;
    final newLost = current.lost + 1;
    
    await _prefs.setInt('stat_streak', 0);
    await _prefs.setInt('stat_lost', newLost);
    
    statsNotifier.value = UserStats(
      streak: 0,
      maxStreak: current.maxStreak,
      solved: current.solved,
      lost: newLost,
      xp: current.xp,
      guessDistribution: current.guessDistribution,
    );
  }
}

final statsManager = StatsManager();