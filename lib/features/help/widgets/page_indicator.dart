import 'package:uniordle/shared/exports/help_exports.dart';

class PageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.accent : AppColors.onSurfaceVariant,
            borderRadius: BorderRadius.circular(64),
          ),
        ),
      ),
    );
  }
}