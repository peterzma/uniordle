import 'package:flutter/services.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
];

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
  final Set<Letter> letters;

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
      child: FittedBox(
        fit: BoxFit.contain,
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
                            : AppColors.surfaceVariant,
                      );
                    },
                  ).toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}