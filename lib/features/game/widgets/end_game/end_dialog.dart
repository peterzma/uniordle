import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';

const Color _topBarWinColor = Color(0xFF55B725);
const Color _topBarLoseColor = Color(0xFFC62121);
const Color _nextGameButtonColour = _topBarWinColor;

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
        horizontal: 20,
      ),
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF1B2E1D),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.stars_rounded,
                color: Color(0xFF55B725),
                size: 60,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              won ? 'YOU WIN!' : 'GAME OVER',
              style: GameFonts.infoBarText.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.onSurfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'THE WORD WAS',
                    style: GameFonts.infoBarText,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      solution.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: '$attempts/$maxAttempts ',
                  ),
                  const TextSpan(
                    text: 'Attempts',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: InfoTag(label: discipline.name, color: AppColors.onSurfaceVariant)),
                const SizedBox(width: 8),
                Expanded(child: InfoTag(label: '${solution.length} LETTERS', color: AppColors.onSurfaceVariant)),
                const SizedBox(width: 8),
                Expanded(child: InfoTag(label: yearLevel.toUpperCase(), color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 32),
            _buildLargeButton(
              label: 'NEW GAME',
              color: const Color(0xFF3B82F6),
              onPressed: onRestart,
            ),
            const SizedBox(height: 12),
            _buildLargeButton(
              label: 'HOME',
              color: const Color(0xFF1E2128),
              onPressed: () => Navigator.pop(context),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildLargeButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}