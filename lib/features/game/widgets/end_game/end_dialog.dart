import 'package:uniordle/shared/exports/end_game_exports.dart';

class EndDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Discipline discipline;
  final VoidCallback onRestart;

  const EndDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.discipline,
    required this.onRestart,
  });

  void _handleNext(BuildContext context) {
    // 1. Get current stats
    final int currentXP = statsManager.statsNotifier.value.xp;
    
    // 2. Calculate logic locally
    final int levelValue = _mapYearToValue(yearLevel);
    final int gainedXP = UserStatsExtension.calculateGainedXP(levelValue, solution.length);
    final int startLevel = currentXP ~/ 100;
    final double startProgress = (currentXP % 100) / 100.0;

    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => 
        LevelUpDialog(
          startingLevel: startLevel,
          startingProgress: startProgress,
          gainedXP: gainedXP.toDouble(),
          discipline: discipline,
        ),
    );
  }

  int _mapYearToValue(String year) {
    if (year.contains('Postgrad')) return 4;
    if (year.contains('3rd')) return 3;
    if (year.contains('2nd')) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16, 
          horizontal: 12
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EndDialogHeader(won: won),
            const SizedBox(height: 12),
            SolutionBox(solution: solution),
            const SizedBox(height: 12),
            AttemptsInfo(attempts: attempts, maxAttempts: maxAttempts, won: won),
            const SizedBox(height: 12),
            GameInfoBar(disciplineName: discipline.name, yearLevel: yearLevel, wordLength: solution.length),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'NEXT',
              color: AppColors.accent,
              onPressed: () => _handleNext(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}