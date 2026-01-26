import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class AppNavItem extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final bool isActive;
  final double iconSize;

  const AppNavItem({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    this.isActive = false,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive 
        ? AppColors.accent 
        : AppColors.onSurfaceVariant;

    return SelectButtonWrapper(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      pressScale: 0.90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: SizedBox(
          height: 48, 
          width: 48,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: color,
              ),
              if (label != null) ...[
                const SizedBox(height: 2),
                Text(
                  label!.toUpperCase(),
                  style: AppFonts.labelSmall.copyWith(color: color),
                ),
              ],
            ],
          ),
        )
      ),
    );
  }
}