import 'package:flutter/material.dart';

// outer box
const double _outerBoxWidth = 24;
const double _outerBoxCorner = 12;

// top bar
const double _topBarHeight = 14;
const double _topBarCorner = 12;
const Color _topBarWinColor = Color(0xFF55B725);
const Color _topBarLoseColor = Color(0xFFC62121);

// small label
const double _smallLabelWidth = 8;
const double _smallLabelHeight = 4;
const double _smallLabelCorner = 10;

// stats box
const double _statsHeight = 22;
const double _statsCorner = 12;
const double _textToStatPadding = 6;

// next game button
const double _nextGameButtonColour = _topBarWinColor;

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
      insetPadding: const EdgeInsets.symmetric(horizontal: _outerBoxWidth),
      backgroundColor: Color(0xFF1E2021),
      shape: RoundedRectangleBorder(
      // bottom of dialog corners
        borderRadius: BorderRadius.circular(_outerBoxCorner),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: _topBarHeight),
            decoration: BoxDecoration(
              color: won ? _topBarWinColor : _topBarLoseColor,
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(_topBarCorner),
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
            padding: const EdgeInsets.all(16), // _inner boxes width padding
            child: Column(
              children: [
                // top left label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _smallLabelWidth,
                      vertical: _smallLabelHeight,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(_smallLabelCorner),
                    ),
                    child: Text(
                      '${solution.length} letters',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // inner box background height
                // two boxes
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'THE WORD WAS',
                        value: solution,
                      ),
                    ),
                    const SizedBox(width: 12), // padding between two boxes
                    Expanded(
                      child: _StatBox(
                        title: 'ATTEMPTS', 
                        value: '$attempts',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // padding between two boxes to bottom box 
                // button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(_nextGameButtonColour),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
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
        color: const Color(0XFF2A2A2A),
        borderRadius: BorderRadius.circular(_statsCorner),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: _textToStatPadding),
          Text(
          value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}