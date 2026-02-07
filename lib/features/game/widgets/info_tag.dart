import 'package:uniordle/shared/exports/game_exports.dart';

class InfoTag extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Widget? icon;

  const InfoTag({
    super.key,
    required this.label,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBg = backgroundColor ?? context.surfaceVariant;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: context.r(4),
        horizontal: context.r(8),
      ),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.labelMedium,
            ),
          ),
          if (icon != null) ...[const SizedBox(width: 4), icon!],
        ],
      ),
    );
  }
}
