import 'package:flutter/material.dart';

const double _outerBoxWidth = 24;
const double _outerBoxCornerRounding = 12;

const double _topColourBarHeight = 14;
const double _topColourBarCornerRounding = 12;

const double _innerBoxWidthPadding = 16;

const double _letterLengthLabelWidth = 8;
const double _letterLengthLabelHeight = 4;
const double _letterLengthLabelCornerRounding = 10;

const double _innerBoxBackgroundHeight = 16;

const double _statsHeight = 22;
const double _statsCornerRounding = 12;
const double _textFontSize = 12;
const double _statFontSize = 28;
const double _textToStatPadding = 6;

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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
      // bottom of dialog corners
        borderRadius: BorderRadius.circular(_outerBoxCornerRounding),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: _topColourBarHeight),
            decoration: BoxDecoration(
              color: won ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.vertical(
              top: Radius.circular(_topColourBarCornerRounding),
              ),
            ),
            child: Text(
              won ? 'YOU WON' : 'YOU LOST',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // content
          Padding(
            padding: const EdgeInsets.all(_innerBoxWidthPadding),
            child: Column(
              children: [
                // top left label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _letterLengthLabelWidth,
                      vertical: _letterLengthLabelHeight,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(_letterLengthLabelCornerRounding),
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
                const SizedBox(height: _innerBoxBackgroundHeight),
                // two boxes
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'THE WORD WAS',
                        value: solution,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatBox(
                        title: 'ATTEMPTS', 
                        value: '$attempts',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onRestart,
                    child: const Text('NEW GAME'),
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
        borderRadius: BorderRadius.circular(_statsCornerRounding),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: _textFontSize,
            ),
          ),
          const SizedBox(height: _textToStatPadding),
          Text(
          value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: _statFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}