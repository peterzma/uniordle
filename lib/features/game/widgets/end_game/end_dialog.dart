import 'package:flutter/material.dart';
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
  final Discipline discipline;
  final VoidCallback onRestart;

  const EndGameDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.discipline,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      backgroundColor: Color(0xFF1E2021),
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
                color: const Color(0xFF1A1D26),
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
                    // width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      solution.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}