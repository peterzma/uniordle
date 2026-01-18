import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/navigation/app_nav_item.dart'; // Adjust based on where your styles are

class BaseHeader extends StatelessWidget implements PreferredSizeWidget {
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
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      height: preferredSize.height + topPadding,
      decoration: BoxDecoration(
        color: AppColors.mainBackground.withValues(alpha: 0.8),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.backgroundBorder,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: height, 
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                style: HomeFonts.titleText,
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