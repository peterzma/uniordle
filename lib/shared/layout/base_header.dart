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
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: AppLayout.barHeight + topPadding,
      padding: EdgeInsets.only(top: topPadding),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppLayout.sidePadding),
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
              NavigationItem(icon: rightIcon!, onTap: onRightTap ?? () {})
            else
                Opacity(
                  opacity: 0,
                  child: IgnorePointer(
                    child: NavigationItem(
                      icon: leftIcon,
                      onTap: () {},
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}