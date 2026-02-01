import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class BaseFooter extends StatelessWidget {
  final List<Widget> children;
  final double height;

  const BaseFooter({
    super.key,
    required this.children,
    this.height = AppLayout.marginHeight,
  });

  @override
  Widget build(BuildContext context) {
  final double bottomPadding = MediaQuery.of(context).padding.bottom;
  final double totalHeight = height + bottomPadding;

    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
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
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.pagePadding),
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