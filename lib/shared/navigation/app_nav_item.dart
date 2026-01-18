import 'package:uniordle/shared/exports/home_screen_exports.dart';
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
        ? AppColors.selectedIcon 
        : AppColors.nonSelectedIcon;

    return PumpButtonWrapper(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      pressScale: 0.90,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              const SizedBox(height: 4),
              Text(
                label!.toUpperCase(),
                style: HomeFonts.iconText(color),
              ),
            ],
          ],
        ),
      ),
    );
  }
}