import 'package:uniordle/shared/exports/profile_exports.dart';

class StatsManager {
  static final StatsManager _instance = StatsManager._internal();
  factory StatsManager() => _instance;
  StatsManager._internal();

  late SharedPreferences _prefs;
  
  final ValueNotifier<UserStats> statsNotifier = ValueNotifier(
    UserStats(streak: 0, solved: 0, xp: 0)
  );

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    final int streak = _prefs.getInt('stat_streak') ?? 0;
    final int solved = _prefs.getInt('stat_solved') ?? 0;
    final int xp = _prefs.getInt('stat_xp') ?? 0;

    statsNotifier.value = UserStats(
      streak: streak, 
      solved: solved, 
      xp: xp
    );
  }

  Future<void> recordWin({required int yearLevel, required int wordLength}) async {
    final current = statsNotifier.value;
    
    // Year 1-4 gives 5-20 XP. Word Length 5-7 gives 0-10 bonus XP.
    final int gainedXP = UserStatsExtension.calculateGainedXP(yearLevel, wordLength);

    final int newSolved = current.solved + 1;
    final int newXP = current.xp + gainedXP;
    final int newStreak = current.streak + 1;
    
    await _prefs.setInt('stat_solved', newSolved);
    await _prefs.setInt('stat_xp', newXP);
    await _prefs.setInt('stat_streak', newStreak);
    
    statsNotifier.value = UserStats(
      streak: newStreak, 
      solved: newSolved, 
      xp: newXP,
    );
  }

  Future<void> recordLoss() async {
    final current = statsNotifier.value;
    const int newStreak = 0; 
    
    await _prefs.setInt('stat_streak', newStreak);
    
    statsNotifier.value = UserStats(
      streak: newStreak, 
      solved: current.solved,
      xp: current.xp,
    );
  }
}

final statsManager = StatsManager();