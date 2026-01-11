import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
];

const _numpad = [
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['0', '.', 'DEL'],
];

class Keyboard extends StatelessWidget {
  const Keyboard({ 
    Key? key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  }): super(key: key);

  final void Function(String) onKeyTapped;

  final VoidCallback onDeleteTapped;

  final VoidCallback onEnterTapped;

  final Set<Letter> letters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty
          .map(
            (keyRow) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: keyRow.map(
                (letter) {
                  if (letter == 'DEL') {
                    return _KeyboardButton.delete(onTap: onDeleteTapped);
                  } else if (letter == 'ENTER') {
                    return _KeyboardButton.enter(onTap: onEnterTapped);
                  }

                  final letterKey = letters.firstWhere(
                    (e) => e.val == letter,
                    orElse: () => Letter.empty(),
                  );

                  return _KeyboardButton(
                    onTap: () => onKeyTapped(letter),
                    letter: letter,
                    backgroundColor: letterKey != Letter.empty()
                        ? letterKey.backgroundColor
                        : Color(0xFF818384),
                  );
                },
              ).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton({ 
    Key? key, 
    this.height = 58,
    this.width = 44,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    }): super(key: key);

    // del and enter keys are special sizes
    factory _KeyboardButton.delete({ 
      required VoidCallback onTap 
    }) =>
      _KeyboardButton(
        width: 66,
        onTap: onTap,
        backgroundColor: Color(0xFF818384),
        child: const Icon(
          Icons.backspace_outlined, 
          color: Colors.white, 
          size: 16
        ),
      );

    factory _KeyboardButton.enter({ 
      required VoidCallback onTap,
    }) =>
      _KeyboardButton(
        width: 66,
        onTap: onTap,
        backgroundColor: Color(0xFF818384),
        letter: 'ENTER',
      );

    final double height;

    final double width;

    final VoidCallback onTap;

    final Color backgroundColor;

    final String? letter;

    final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 3.0,
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
        child: InkWell(
          // bloom effect on button click
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            child: child ?? Text(
              letter ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}