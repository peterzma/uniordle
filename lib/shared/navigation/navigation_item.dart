import 'package:uniordle/shared/exports/core_exports.dart';

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final bool isActive;
  final double iconSize;
  final Color? color;
  final double width;

  const NavigationItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    this.isActive = false,
    this.iconSize = 24,
    this.color,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    final Color finalColor =
        color ??
        (isActive
            ? context.colorScheme.primary
            : context.colorScheme.onSurfaceVariant);

    return SelectButtonWrapper(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      pressScale: 0.95,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 48,
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: finalColor),
              if (label != null) ...[
                const SizedBox(height: 2),
                Text(
                  label!.toUpperCase(),
                  style: context.labelSmall.copyWith(color: finalColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
