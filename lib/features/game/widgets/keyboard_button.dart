import 'package:uniordle/shared/exports/game_exports.dart';

class KeyboardButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final String? letter;
  final Widget? child;
  final SoundType soundType;

  const KeyboardButton({
    super.key,
    this.height = 66,
    this.width = 40,
    required this.onTap,
    this.backgroundColor,
    this.letter,
    this.child,
    this.soundType = SoundType.keyboard,
  });

  factory KeyboardButton.delete({required VoidCallback onTap}) =>
      KeyboardButton(
        width: 62,
        onTap: onTap,
        soundType: SoundType.delete,
        child: Icon(AppIcons.gameBackspace, size: 22),
      );

  factory KeyboardButton.enter({required VoidCallback onTap}) => KeyboardButton(
    width: 62,
    onTap: onTap,
    letter: 'ENTER',
    soundType: SoundType.enter,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.r(4)),
      child: SelectButtonWrapper(
        onTap: onTap,
        enableDarken: true,
        baseColor: backgroundColor ?? context.surfaceVariant,
        soundType: soundType,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(child: _buildContent(context, context.onSurface)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color color) {
    if (child is Icon) {
      final Icon icon = child as Icon;
      return Icon(icon.icon, color: color, size: icon.size);
    }

    if (letter == 'ENTER') {
      return Text(
        'ENTER',
        style: context.textTheme.labelLarge?.copyWith(color: color),
      );
    }

    return Text(
      letter ?? '',
      style: context.displayMedium.copyWith(fontSize: 24, color: color),
    );
  }
}
