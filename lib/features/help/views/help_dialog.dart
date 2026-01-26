import 'package:uniordle/shared/exports/help_exports.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.surface, 
          borderRadius: BorderRadius.circular(32),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) => setState(() => _currentPage = index),
                      children: [
                        const HowToPlay(),
                        const LevelUp(),
                        const ReachTop(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  PageIndicator(
                    totalPages: _totalPages,
                    currentPage: _currentPage,
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'Got it!',
                    onPressed: () => Navigator.pop(context),
                    borderRadius: 16,
                    height: 48,
                    width: 400
                  ),
                ],
              ),
            ),

            // Left Arrow
            if (_currentPage > 0)
              NavArrow(
                isLeft: true,
                onTap: () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuart,
                ),
              ),

            // Right Arrow
            if (_currentPage < _totalPages - 1)
              NavArrow(
                isLeft: false,
                onTap: () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuart,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NavArrow extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const NavArrow({
    super.key,
    required this.isLeft,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 20,
      left: isLeft ? -60 : null,
      right: !isLeft ? -60 : null,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 80,
          height: 100,
          alignment: isLeft ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLeft ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
              color: AppColors.outline,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}