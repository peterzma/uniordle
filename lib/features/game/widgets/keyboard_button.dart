import 'package:uniordle/shared/exports/game_screen_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

const double _specialKeyWidth = 70;

/// A single key used on the keyboard
/// 
/// Provides press and tap animation with darkening
class KeyboardButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String? letter;
  final Widget? child;
  final SoundType soundType;

  const KeyboardButton({ 
    super.key,
    this.height = 64,
    this.width = 44,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    this.soundType = SoundType.keyboard,
  });


  factory KeyboardButton.delete({required VoidCallback onTap}) =>
      KeyboardButton(
        width: _specialKeyWidth,
        onTap: onTap,
        backgroundColor: AppColors.onSurfaceVariant,
        soundType: SoundType.delete,
        child: const Icon(Icons.backspace, color: Colors.white, size: 22),
      );

  factory KeyboardButton.enter({required VoidCallback onTap}) =>
      KeyboardButton(
        width: _specialKeyWidth,
        onTap: onTap,
        backgroundColor: AppColors.onSurfaceVariant,
        letter: 'ENTER',
        soundType: SoundType.enter,
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
      padding: const EdgeInsets.all(4),
      child: PumpButtonWrapper(
        onTap: onTap,
        pressScale: 0.95,
        enableDarken: true,
        baseColor: backgroundColor,
        soundType: soundType,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: child ?? Text(
              letter ?? '',
              style: GameFonts.keyText,
            ),
          ),
        )
      )
    );
  }
}
