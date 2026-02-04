import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/navigation/navigation_item.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final VoidCallback onLeftTap;
  final IconData? rightIcon;
  final VoidCallback? onRightTap;
  final List<Widget>? actions;
  final double height;

  const BaseHeader({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.onLeftTap,
    this.rightIcon,
    this.onRightTap,
    this.actions,
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
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: NavigationItem(
                    icon: leftIcon,
                    onTap: onLeftTap,
                  ),
                ),
              ),
              Text(
                title,
                style: AppFonts.displayMedium,
                textAlign: TextAlign.center,
              ),
              Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: actions != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min, 
                        children: actions!,
                      )
                    : rightIcon != null
                        ? NavigationItem(
                            icon: rightIcon!,
                            onTap: onRightTap ?? () {},
                          )
                        : const SizedBox.shrink(),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}