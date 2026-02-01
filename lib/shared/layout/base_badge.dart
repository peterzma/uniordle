import 'package:uniordle/shared/exports/game_exports.dart';

class BaseBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final double iconSize;

  const BaseBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.r(16), vertical: context.r(8)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: color),
          SizedBox(width: context.r(8)),
          context.autoText(
            label.toUpperCase(),
            style: AppFonts.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}