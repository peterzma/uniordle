import 'package:flutter/services.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';

const _qwerty = [
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
      SoundManager().play(SoundType.enter);
    } else if (key == 'Backspace') {
      onDeleteTapped();
      SoundManager().play(SoundType.delete);
    } else {
      final upper = key.toUpperCase();
      if (_qwerty.any((row) => row.contains(upper))) {
        onKeyTapped(upper);
          SoundManager().play(SoundType.keyboard);
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
                          : AppColors.onSurfaceVariant,
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