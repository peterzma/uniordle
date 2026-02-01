import 'package:uniordle/shared/exports/game_exports.dart';

class InfoTag extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Widget? icon;

  const InfoTag({
    super.key, 
    required this.label, 
    this.backgroundColor = AppColors.surfaceVariant,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: context.r(4), horizontal: context.r(8)),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.5),
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
          if (icon != null) ...[
            const SizedBox(width: 4),
            icon!,
          ],
        ],
      ),
    );
  }
}