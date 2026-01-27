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
      leftAction: _currentPage > 0
          ? NavHitArea(
              isLeft: true,
              onTap: () => _pageController.jumpToPage(_currentPage - 1),
            )
          : null,
      rightAction: _currentPage < _totalPages - 1
          ? NavHitArea(
              isLeft: false,
              onTap: () => _pageController.jumpToPage(_currentPage + 1),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 320,
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
            color: AppColors.accent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class NavHitArea extends StatelessWidget {
  final bool isLeft;
  final VoidCallback onTap;

  const NavHitArea({super.key, required this.isLeft, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40, 
        height: 300, 
        alignment: Alignment.center,
        child: Icon(
          isLeft ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
          color: AppColors.onSurfaceVariant,
          size: 30,
        ),
      ),
    );
  }
}