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
    this.height = 66,
    this.width = 40,
    required this.onTap,
    required this.backgroundColor,
    this.letter,
    this.child,
    this.soundType = SoundType.keyboard,
  });


  factory KeyboardButton.delete({required VoidCallback onTap}) =>
      KeyboardButton(
        width: 62,
        onTap: onTap,
        backgroundColor: AppColors.gameTiles,
        soundType: SoundType.delete,
        child: Icon(
          AppIcons.backspace, 
          color: Colors.white, 
          size: 22
        ),
      );

  factory KeyboardButton.enter({required VoidCallback onTap}) =>
      KeyboardButton(
        width: 62,
        onTap: onTap,
        backgroundColor: AppColors.gameTiles,
        letter: 'ENTER',
        soundType: SoundType.enter,
        child: Text(
          'ENTER',
          style: AppFonts.labelLarge
        ),
      );

  @override
  Widget build(BuildContext context) {
    final double availableWidth = AppLayout.contentWidth(context);
    final double scaleFactor = (availableWidth / AppLayout.maxAppWidth).clamp(0.7, 1.0);
    final double dynamicPadding = 4.0 * scaleFactor;

    return Padding(
      padding: EdgeInsets.all(dynamicPadding),
      child: SelectButtonWrapper(
        onTap: onTap,
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
