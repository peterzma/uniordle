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
        decoration: BoxDecoration(
          color: AppColors.surface, 
          borderRadius: BorderRadius.circular(32),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    children: [
                      const HowToPlay(),
                      const Center(child: Text("Slide 2", style: TextStyle(color: Colors.white))),
                      const Center(child: Text("Slide 3", style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_totalPages, (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.accent : AppColors.outline,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  )),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Got it!',
                  onPressed: () => Navigator.pop(context),
                  borderRadius: 16,
                ),
              ],
            ),

            // Left Arrow
            if (_currentPage > 0)
              Positioned(
                left: -20,
                top: 180,
                child: _NavArrow(
                  icon: LucideIcons.chevronLeft,
                  onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutQuart,
                  ),
                ),
              ),

            // Right Arrow
            if (_currentPage < _totalPages - 1)
              Positioned(
                right: -20,
                top: 180,
                child: _NavArrow(
                  icon: LucideIcons.chevronRight,
                  onTap: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutQuart,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: AppColors.outline),
      onPressed: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }
}