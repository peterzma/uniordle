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

  void _handlePhysicalKey(String keyLabel) {
    if (keyLabel == 'Enter') {
      onEnterTapped();
      SoundManager().play(SoundType.enter);
    } else if (keyLabel == 'Backspace') {
      onDeleteTapped();
      SoundManager().play(SoundType.delete);
    } else {
      final upper = keyLabel.toUpperCase();
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _qwerty.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final List<String> keyRow = entry.value;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (index == 1) const SizedBox(width: 20),

                      ...keyRow.map((letter) {
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
                              : AppColors.gameTiles,
                        );
                      }),

                      if (index == 1) const SizedBox(width: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}