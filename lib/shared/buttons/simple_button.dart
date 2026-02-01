import 'package:uniordle/shared/exports/game_exports.dart';

class SimpleButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? color;
  final double? iconSize;
  final EdgeInsets? padding;

  const SimpleButton({
    super.key,
    this.text,
    this.icon,
    required this.onTap,
    this.color,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? AppColors.accent;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.white.withValues(alpha: 0.1);
            }
            return null;
          },
        ),
        padding: WidgetStateProperty.all(padding ?? const EdgeInsets.all(16)),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: WidgetStateProperty.all(
          text == null ? const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: displayColor,
              size: iconSize ?? 18,
            ),
          if (icon != null && text != null) const SizedBox(width: 8),
          if (text != null)
            context.autoText(
              text!,
              style: AppFonts.labelSmall.copyWith(
                color: displayColor,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}