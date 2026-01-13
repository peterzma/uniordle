import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app_colors.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

const _qwerty = [
  ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
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
                        : keyBackground,
                  );
                },
              ).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyboardButton extends StatefulWidget {
  const _KeyboardButton({ 
    Key? key, 
    this.height = 64,
    this.width = 44,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    }): super(key: key);

    final double height;
    final double width;
    final VoidCallback onTap;
    final Color backgroundColor;
    final String? letter;
    final Widget? child;

    // del and enter keys are special sizes
    factory _KeyboardButton.delete({ 
      required VoidCallback onTap 
    }) =>
      _KeyboardButton(
        width: 66,
        onTap: onTap,
        backgroundColor: keyBackground,
        child: Transform.translate(
          offset: const Offset(0, -3),
          child: const Icon(
            Icons.backspace, 
            color: Colors.white, 
            size: 22
          ),
        ),
      );

    factory _KeyboardButton.enter({ 
      required VoidCallback onTap,
    }) =>
      _KeyboardButton(
        width: 66,
        onTap: onTap,
        backgroundColor: keyBackground,
        letter: 'ENTER',
        child: Transform.translate(
          offset: const Offset(0, -3),
          child: const Text(
            'ENTER',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );

  @override
  State<_KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<_KeyboardButton> with SingleTickerProviderStateMixin{
  bool _isPressed = false;
  bool _isTapped = false;

  static const int _pressSpeed = 80; // ms
  static const int _tapSpeed = 80; // ms for full animation
  static const int _darkenSpeed = 10; // ms
  static const double _darkenIntensity = 0.2;
  static const double _keyboardTextOffset = -2.0;


  void _handleTap() {
    // trigger tap animation
    setState(() => _isTapped = true);
    Future.delayed(const Duration(milliseconds: _tapSpeed), () {
      if (mounted) setState(() => _isTapped = false);
    });

    widget.onTap();
  }

    double get _currentScale {
    if (_isTapped) return 0.95; // start of tap animation
    return _isPressed ? 0.95 : 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0, 
        vertical: 4.0,
      ),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _handleTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _currentScale),
          duration: _isTapped
              ? const Duration(milliseconds: _tapSpeed)
              : const Duration(milliseconds: _pressSpeed),
          curve: Curves.easeInOut,
          builder: (context, scale, child) => Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: _darkenSpeed),
              height: widget.height,
              width: widget.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isPressed || _isTapped
                    ? Color.alphaBlend(
                      Colors.black.withValues(alpha: _darkenIntensity), 
                        widget.backgroundColor
                      )
                    : widget.backgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: widget.child ?? Transform.translate(
                offset: const Offset(0, _keyboardTextOffset),
                child: widget.child ?? Text(
                  widget.letter ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'dm-sans',
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}