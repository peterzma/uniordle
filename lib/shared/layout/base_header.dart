import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/navigation/app_nav_item.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final VoidCallback onLeftTap;
  final IconData? rightIcon;
  final VoidCallback? onRightTap;
  final double height;

  const BaseHeader({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.onLeftTap,
    this.rightIcon,
    this.onRightTap,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: AppLayout.barHeight + topPadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.outline,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.kSidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppNavItem(
                icon: leftIcon,
                onTap: onLeftTap,
              ),
              Text(
                title,
                style: AppFonts.displayMedium,
              ),
              rightIcon != null
                  ? AppNavItem(icon: rightIcon!, onTap: onRightTap ?? () {})
                  : const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}