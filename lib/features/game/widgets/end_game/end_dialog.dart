import 'package:uniordle/features/game/widgets/end_game/attempts_info.dart';
import 'package:uniordle/features/game/widgets/end_game/end_dialog_header.dart';
import 'package:uniordle/features/game/widgets/end_game/solution_box.dart';
import 'package:uniordle/features/game/widgets/game_info_bar.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/base_dialog.dart';
import 'package:uniordle/features/profile/models/user_stats.dart';

/// Dialog shown when game ends
/// 
/// Displays win or loss, solution world, attempt count,
/// and actions to restart or go back to main menu
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

  @override
  Widget build(BuildContext context) {
    final int levelValue = _mapYearToValue(yearLevel);
    final gainedCredits = UserStatsExtension.calculateGainedXP(levelValue, solution.length);

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
            if (won) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                ),
                child: Text(
                  '+$gainedCredits MERITS',
                  style: AppFonts.labelMedium.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            SolutionBox(solution: solution),
            const SizedBox(height: 12),
            AttemptsInfo(attempts: attempts, maxAttempts: maxAttempts, won: won),
            const SizedBox(height: 12),
            GameInfoBar(disciplineName: discipline.name, yearLevel: yearLevel, wordLength: solution.length),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'NEW GAME',
              color: AppColors.accent,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/setup',
                  arguments: discipline
                );
              },
              borderRadius: 24,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'HOME',
              borderRadius: 24,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

int _mapYearToValue(String year) {
  if (year.contains('1st')) return 1;
  if (year.contains('2nd')) return 2;
  if (year.contains('3rd')) return 3;
  return 4; // Postgrad
}