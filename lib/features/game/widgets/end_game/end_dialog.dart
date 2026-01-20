import 'package:flutter/material.dart';
import 'package:uniordle/features/game/widgets/end_game/stat_box.dart';
import 'package:uniordle/features/game/widgets/end_game/action_button.dart';
import 'package:uniordle/features/home/models/discipline.dart';

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
        vertical: 24,
      ),
      backgroundColor: Color(0xFF1E2021),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // top bar
          Container(
            width: double.infinity, // expands dialog box width
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: won ? _topBarWinColor : _topBarLoseColor,
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
              ),
            ),
            child: Text(
              won ? 'You Won!' : 'Game Over',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'clashdisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20, 
              vertical: 20,
            ), // inner boxes width padding
            child: Column(
              children: [
                // top left label
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF27282A),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          '${solution.length} Letters',
                          style: const TextStyle(
                            color: Color(0xFFB0B4B7),
                            fontSize: 14,
                            fontFamily: 'dm-sans',
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                // two boxes
                const SizedBox(height: 16), // space between letters container and two stat boxes
                Row(
                  children: [
                    Expanded(
                      child: StatBox(
                        title: 'THE WORD WAS',
                        value: solution,
                      ),
                    ),
                    const SizedBox(width: 16), // padding between two boxes
                    Expanded(
                      child: StatBox(
                        title: 'ATTEMPTS', 
                        value: '$attempts',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32), // padding between two boxes to bottom box 
                // button
                Row(
                  children: [
                    ActionButton(
                      label: 'Back', 
                      onPressed: () => Navigator.pop(context), 
                      color: Color(0xFF1E2021),
                      hasBorder: true,
                    ),
                    const SizedBox(width: 16),
                    ActionButton(
                      label: 'New Game',
                      onPressed: onRestart,
                      color: _nextGameButtonColour,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}