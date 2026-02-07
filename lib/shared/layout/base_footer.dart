import 'package:uniordle/shared/exports/core_exports.dart';

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
        color: context.surface,
        border: const Border(
          top: BorderSide(color: context.colorScheme.outline, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppLayout.pagePadding,
          ),
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
