import 'package:uniordle/shared/game_screen_exports.dart';
import 'package:uniordle/shared/widgets/pump_button_wrapper.dart';

const double _keyHeight = 64;
const double _keyWidth = 44;
const double _keyFontSize = 24;
const double _gapPadding = 4;
const double _specialKeyWidth = 70;

/// A single key used on the keyboard
/// 
/// Provides press and tap animation with darkening
class KeyboardButton extends StatelessWidget {
  const KeyboardButton({ 
    super.key,
    this.height = _keyHeight,
    this.width = _keyWidth,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    });

    final double height;
    final double width;
    final VoidCallback onTap;
    final Color backgroundColor;
    final String? letter;
    final Widget? child;

  factory KeyboardButton.delete({required VoidCallback onTap}) =>
      KeyboardButton(
        width: _specialKeyWidth,
        onTap: onTap,
        backgroundColor: AppColors.keyBackground,
        child: const Icon(Icons.backspace, color: Colors.white, size: 22),
      );

  factory KeyboardButton.enter({required VoidCallback onTap}) =>
      KeyboardButton(
        width: _specialKeyWidth,
        onTap: onTap,
        backgroundColor: AppColors.keyBackground,
        letter: 'ENTER',
        child: const Text(
          'ENTER',
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_gapPadding),
      child: PumpButtonWrapper(
        onTap: onTap,
        pressScale: 0.95,
        enableDarken: true,
        baseColor: backgroundColor,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: child ?? Text(
              letter ?? '',
              style: const TextStyle(
                fontSize: _keyFontSize,
                fontFamily: 'dm-sans',
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        )
      )
    );
  }
}
