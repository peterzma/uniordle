import 'package:uniordle/shared/exports/end_game_exports.dart';

class EndDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Discipline discipline;
  final int gainedMerit;

  const EndDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.discipline,
    required this.gainedMerit,
  });

  void _handleNext(BuildContext context) {
    final currentStats = statsManager.statsNotifier.value;
    
    final double directedMerit = won ? gainedMerit.toDouble() : -gainedMerit.toDouble();

    final prevState = UserStatsExtension.getPreviousState(
    currentStats.merit, 
    directedMerit.toInt(),
    );

    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => LevelUpDialog(
        startingLevel: prevState.$1,
        startingProgress: prevState.$2,
        gainedMerit: directedMerit,
        discipline: discipline,
      ),
    );
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