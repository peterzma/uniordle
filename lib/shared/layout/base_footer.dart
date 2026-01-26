import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class BaseFooter extends StatelessWidget {
  final List<Widget> children;
  final double height;

  const BaseFooter({
    super.key,
    required this.children,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: AppLayout.barHeight + bottomPadding,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.kSidePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children, 
          ),
        ),
      ),
    );
  }
}