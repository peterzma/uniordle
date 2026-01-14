import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/uniordle/uniordle.dart';
import 'package:flutter/services.dart';
import 'package:uniordle/uniordle/widgets/keyboard_button.dart';

const _qwerty = [
  ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
];

/// On-screen keyboard for Uniordle
/// 
/// Supports both touch input and physical keyboard input
/// Updates key colours based on [Letter] states
class Keyboard extends StatelessWidget {
  const Keyboard({ 
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  /// Set of letters to colour keyboard keys
  final Set<Letter> letters;

  /// Handles physical keyboard inputs and maps to game actions
  void _handlePhysicalKey(String key) {
    if (key == 'Enter') {
      onEnterTapped();
    } else if (key == 'Backspace') {
      onDeleteTapped();
    } else {
      final upper = key.toUpperCase();
      if (_qwerty.any((row) => row.contains(upper))) {
        onKeyTapped(upper);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          _handlePhysicalKey(event.logicalKey.keyLabel);
        }
        return KeyEventResult.handled;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _qwerty
            .map(
              (keyRow) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keyRow.map(
                  (letter) {
                    if (letter == 'DEL') {
                      return KeyboardButton.delete(onTap: onDeleteTapped);
                    } else if (letter == 'ENTER') {
                      return KeyboardButton.enter(onTap: onEnterTapped);
                    }

                    final letterKey = letters.firstWhere(
                      (e) => e.val == letter,
                      orElse: () => Letter.empty(),
                    );

                    return KeyboardButton(
                      onTap: () => onKeyTapped(letter),
                      letter: letter,
                      backgroundColor: letterKey != Letter.empty()
                          ? letterKey.backgroundColor
                          : keyBackground,
                    );
                  },
                ).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}