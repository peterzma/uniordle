import 'package:uniordle/shared/exports/home_screen_exports.dart';

class BaseFooter extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  const BaseFooter({
    super.key,
    required this.child,
    this.height = 72,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: preferredSize.height + bottomPadding,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(
            color: AppColors.outline,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}