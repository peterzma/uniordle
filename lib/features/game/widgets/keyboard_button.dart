import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

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
        width: 70,
        onTap: onTap,
        backgroundColor: AppColors.surfaceVariant,
        soundType: SoundType.delete,
        child: Icon(
          AppIcons.backspace, 
          color: Colors.white, 
          size: 22
        ),
      );

  factory KeyboardButton.enter({required VoidCallback onTap}) =>
      KeyboardButton(
        width: 70,
        onTap: onTap,
        backgroundColor: AppColors.surfaceVariant,
        letter: 'ENTER',
        soundType: SoundType.enter,
        child: Text(
          'ENTER',
          style: AppFonts.labelLarge
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SelectButtonWrapper(
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
              style: AppFonts.displayMedium.copyWith(fontSize: 24),
            ),
          ),
        )
      )
    );
  }
}
