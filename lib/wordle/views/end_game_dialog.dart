import 'package:flutter/material.dart';

// outer box
const double _outerBoxWidth = 232;

// top bar
const double _topBarHeight = 12;
const Color _topBarWinColor = Color(0xFF55B725);
const Color _topBarLoseColor = Color(0xFFC62121);

// stats box
const double _statsHeight = 24;
const double _textToStatPadding = 8;

// next game button
const Color _nextGameButtonColour = _topBarWinColor;

class EndGameDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final VoidCallback onRestart;

  const EndGameDialog({
    required this.won,
    required this.solution,
    required this.attempts,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: _outerBoxWidth,
      ),
      backgroundColor: Color(0xFF1E2021),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // top bar
          Container(
            width: double.infinity, // expands dialog box width
            padding: const EdgeInsets.symmetric(vertical: _topBarHeight),
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
              vertical: 16
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
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(height: 16) // space between letters container and two stat boxes
                    ],
                  ),
                const SizedBox(height: 2), // padding between top bar and two boxes
                // two boxes
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'THE WORD WAS',
                        value: solution,
                      ),
                    ),
                    const SizedBox(width: 18), // padding between two boxes
                    Expanded(
                      child: _StatBox(
                        title: 'ATTEMPTS', 
                        value: '$attempts',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64), // padding between two boxes to bottom box 
                // button
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'clashdisplay',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onRestart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _nextGameButtonColour,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: Text(
                          'New Game',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'clashdisplay',
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
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

// two centre buttons
class _StatBox extends StatelessWidget {
  final String title;
  final String value;

  const _StatBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.symmetric(vertical: _statsHeight),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2021),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF303436)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF8E9599),
              fontSize: 16,
              fontFamily: 'dm-sans',
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: _textToStatPadding),
          Text(
          value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontFamily: 'clashdisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}