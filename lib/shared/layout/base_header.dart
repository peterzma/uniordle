import 'package:uniordle/shared/exports/core_exports.dart';

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
        color: context.surface,
        border: const Border(
          bottom: BorderSide(color: AppColorsDark.outline, width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppLayout.pagePadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: NavigationItem(icon: leftIcon, onTap: onLeftTap),
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  title,
                  style: AppFonts.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: actions != null
                      ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
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
