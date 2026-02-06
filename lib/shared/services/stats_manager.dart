import 'dart:convert';
import 'dart:math';
import 'package:uniordle/features/home/data/major_data.dart';
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
    final unlocked = _prefs.getStringList('unlocked_majors') ?? [];
    final milestonesRaw = _prefs.getStringList('stat_milestones') ?? [];

    final modeFreqString = _prefs.getString('stat_mode_freq') ?? '{}';
    final Map<String, dynamic> decodedModeFreq = jsonDecode(modeFreqString);
    final Map<String, int> modeFrequency = decodedModeFreq.map((k, v) => MapEntry(k, v as int));

    final historyRaw = _prefs.getString('stat_game_history') ?? '[]';
    final List<dynamic> decodedHistory = jsonDecode(historyRaw);
    final List<Map<String, dynamic>> gameHistory = decodedHistory.cast<Map<String, dynamic>>();

    final solvedWords = _prefs.getStringList('stat_solved_words') ?? [];
    
    final Map<int, int> distribution = {
      for (var e in decodedDist.entries) int.parse(e.key): e.value as int
    };

    final Map<int, int> fullDistribution = {
      for (int i = 1; i <= 8; i++) i: distribution[i] ?? 0
    };

    final int extraBoosts = _prefs.getInt('stat_extra_boosts') ?? 0;

    statsNotifier.value = UserStats(
      streak: _prefs.getInt('stat_streak') ?? 0,
      maxStreak: _prefs.getInt('stat_max_streak') ?? 0,
      solved: _prefs.getInt('stat_solved') ?? 0,
      lost: _prefs.getInt('stat_lost') ?? 0,
      merit: _prefs.getInt('stat_merit') ?? 0,
      // merit: 12400,
      guessDistribution: fullDistribution,
      unlockedIds: unlocked,
      achievedMilestones: milestonesRaw.map(int.parse).toList(),
      modeFrequency: modeFrequency,
      gameHistory: gameHistory,
      solvedWords: solvedWords,
      extraBoosts: extraBoosts,
    );
  }

  Future<int> recordWin({
    required int yearLevel, 
    required int wordLength, 
    required int attempts, 
    required int maxAttempts,
    required String word,
    required String majorId,
  }) async {
    final current = statsNotifier.value;

    final int gainedMerit = UserStatsRewards.generateGainedMerit(
      stats: current, 
      yearLevel: yearLevel, 
      wordLength: wordLength, 
      attempts: attempts,
      majorId: majorId,
    );

    final int newMerit = current.merit + gainedMerit;
    final newStreak = current.streak + 1;
    final newMaxStreak = max(newStreak, current.maxStreak);
    
    final newDist = Map<int, int>.from(current.guessDistribution);
    newDist[attempts] = (newDist[attempts] ?? 0) + 1;

    final newSolvedWords = List<String>.from(current.solvedWords);
    if (!newSolvedWords.contains(word.toUpperCase())) {
      newSolvedWords.add(word.toUpperCase());
      await _prefs.setStringList('stat_solved_words', newSolvedWords);
    }

    final updatedHistory = _generateUpdatedHistory(
      current: current,
      word: word,
      won: true,
      attempts: attempts,
      maxAttempts: maxAttempts,
      merit: gainedMerit,
    );

    final updatedModeFreq = await _incrementModeFrequency(wordLength, maxAttempts);

    await _prefs.setInt('stat_merit', newMerit);
    await _prefs.setInt('stat_streak', newStreak);
    await _prefs.setInt('stat_max_streak', newMaxStreak);
    await _prefs.setInt('stat_solved', current.solved + 1);
    await _prefs.setString('stat_dist', jsonEncode(newDist.map((k, v) => MapEntry(k.toString(), v))));

    statsNotifier.value = current.copyWith(
      streak: newStreak,
      maxStreak: newMaxStreak,
      solved: current.solved + 1,
      merit: newMerit,
      guessDistribution: newDist,
      modeFrequency: updatedModeFreq,
      gameHistory: updatedHistory,
      solvedWords: newSolvedWords,
    );

    return gainedMerit;
  }

  Future<void> recordLoss({
    required String word, 
    required int wordLength, 
    required int maxAttempts
  }) async {
    final current = statsNotifier.value;
    return _handleFailure(
      word: word,
      wordLength: wordLength,
      maxAttempts: maxAttempts,
      penalty: current.standardPenalty,
    );
  }

  Future<void> recordAbandonment({
    required String word, 
    required int wordLength, 
    required int maxAttempts
  }) async {
    final current = statsNotifier.value;
    return _handleFailure(
      word: word,
      wordLength: wordLength,
      maxAttempts: maxAttempts,
      penalty: current.activePenalty,
    );
  }

  Future<void> _handleFailure({
    required String word,
    required int wordLength,
    required int maxAttempts,
    required int penalty,
  }) async {
    final current = statsNotifier.value;
    final newLost = current.lost + 1;
    final newMerit = max(0, current.merit - penalty);

    final updatedModeFreq = await _incrementModeFrequency(wordLength, maxAttempts);

    final updatedHistory = _generateUpdatedHistory(
      current: current,
      word: word,
      won: false,
      attempts: maxAttempts,
      maxAttempts: maxAttempts,
      merit: -penalty,
    );

    await _prefs.setInt('stat_streak', 0);
    await _prefs.setInt('stat_lost', newLost);
    await _prefs.setInt('stat_merit', newMerit);

    statsNotifier.value = current.copyWith(
      streak: 0,
      lost: newLost,
      merit: newMerit,
      modeFrequency: updatedModeFreq,
      gameHistory: updatedHistory,
    );
  }

  Future<void> applyMajorBonusBoost() async {
    final current = statsNotifier.value;
    
    final bool allMajorsUnlocked = current.unlockedIds.length >= MajorsData.all.length;
    
    if (!allMajorsUnlocked || current.availableCredits <= 0) {
      return;
    }

    final int newBoostCount = current.extraBoosts + 1;
    await _prefs.setInt('stat_extra_boosts', newBoostCount);
    
    statsNotifier.value = current.copyWith(
      extraBoosts: newBoostCount,
    );
  }

  Future<void> unlockMajor(String id) async {
    final current = statsNotifier.value;
    if (current.unlockedIds.contains(id)) return;

    final newList = List<String>.from(current.unlockedIds)..add(id);
    await _prefs.setStringList('unlocked_majors', newList);
    
    statsNotifier.value = current.copyWith(unlockedIds: newList);
  }

  Future<Map<String, int>> _incrementModeFrequency(int length, int maxAttempts) async {
    final current = statsNotifier.value;
    final String modeKey = "$length-$maxAttempts";
    
    final newFreq = Map<String, int>.from(current.modeFrequency);
    newFreq[modeKey] = (newFreq[modeKey] ?? 0) + 1;

    await _prefs.setString('stat_mode_freq', jsonEncode(newFreq));
    
    statsNotifier.value = current.copyWith(modeFrequency: newFreq);
    
    return newFreq;
  }

  List<Map<String, dynamic>> _generateUpdatedHistory({
    required UserStats current,
    required String word,
    required bool won,
    required int attempts,
    required int maxAttempts,
    required int merit,
  }) {
    final List<Map<String, dynamic>> updatedHistory = List.from(current.gameHistory);

    // Add the new entry
    updatedHistory.add({
      'word': word,
      'won': won,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'merit': merit,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    if (updatedHistory.length > 50) {
      updatedHistory.removeAt(0);
    }

    _prefs.setString('stat_game_history', jsonEncode(updatedHistory));

    return updatedHistory;
  }

  Future<void> reinitialize() async {
    statsNotifier.value = UserStats(streak: 0, solved: 0, merit: 0);
    await init();
  }
}

  final statsManager = StatsManager();