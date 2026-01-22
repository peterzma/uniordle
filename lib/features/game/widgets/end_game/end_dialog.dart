import 'package:uniordle/features/game/widgets/end_game/attempts_info.dart';
import 'package:uniordle/features/game/widgets/end_game/end_dialog_header.dart';
import 'package:uniordle/features/game/widgets/end_game/solution_box.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';

/// Dialog shown when game ends
/// 
/// Displays win or loss, solution world, attempt count,
/// and actions to restart or go back to main menu
class EndGameDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Discipline discipline;
  final VoidCallback onRestart;

  const EndGameDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.discipline,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeader(won: won),
            const SizedBox(height: 24),
            SolutionBox(solution: solution),
            const SizedBox(height: 24),
            AttemptsInfo(attempts: attempts, maxAttempts: maxAttempts, won: won),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: InfoTag(label: discipline.name)),
                const SizedBox(width: 8),
                Expanded(child: InfoTag(label: '${solution.length} LETTERS')),
                const SizedBox(width: 8),
                Expanded(child: InfoTag(label: yearLevel.toUpperCase())),
              ],
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'NEW GAME',
              color: AppColors.accent,
              onPressed: onRestart,
              borderRadius: 24,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'HOME',
              color: AppColors.surfaceVariant,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
              borderRadius: 24,
            ),
          ],
        ),
      ),
    );
  }
}