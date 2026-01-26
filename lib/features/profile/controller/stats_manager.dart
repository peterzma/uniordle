import 'package:uniordle/shared/exports/profile_exports.dart';

class StatsManager {
  static final StatsManager _instance = StatsManager._internal();
  factory StatsManager() => _instance;
  StatsManager._internal();

  late SharedPreferences _prefs;
  
  final ValueNotifier<UserStats> statsNotifier = ValueNotifier(UserStats(streak: 0, solved: 0));

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final int streak = _prefs.getInt('stat_streak') ?? 0;
    final int solved = _prefs.getInt('stat_solved') ?? 0;
    statsNotifier.value = UserStats(streak: streak, solved: solved);
  }

  Future<void> recordWin() async {
    final newSolved = statsNotifier.value.solved + 1;
    final newStreak = statsNotifier.value.streak + 1;
    
    await _prefs.setInt('stat_solved', newSolved);
    await _prefs.setInt('stat_streak', newStreak);
    
    statsNotifier.value = UserStats(streak: newStreak, solved: newSolved);
  }

  Future<void> recordLoss() async {
    const newStreak = 0; // Reset streak on loss
    await _prefs.setInt('stat_streak', newStreak);
    
    statsNotifier.value = UserStats(
      streak: newStreak, 
      solved: statsNotifier.value.solved,
    );
  }
}

final statsManager = StatsManager();