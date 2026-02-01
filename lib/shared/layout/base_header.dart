import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/navigation/navigation_item.dart';

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
    this.height = AppLayout.marginHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
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
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.pagePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavigationItem(
                icon: leftIcon,
                onTap: onLeftTap,
              ),
              Text(
                title,
                style: AppFonts.displayMedium,
              ),
              if (rightIcon != null)
                NavigationItem(
                  icon: rightIcon!,
                  onTap: onRightTap ?? () {},
                )
              else
                Opacity(
                  opacity: 0,
                  child: IgnorePointer(
                    child: NavigationItem(
                      icon: Icons.circle,
                      onTap: () {},
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}