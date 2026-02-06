import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/help/widgets/risk_and_reward.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 4;

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
            height: context.responsive(250, 320),
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: [
                const HowToPlay(),
                const LevelUp(),
                const RiskAndReward(),
                const RiseAndReach(),
              ],
            ),
          ),
          SizedBox(height: context.responsive(4, 16)),
          PageIndicator(
            totalPages: _totalPages,
            currentPage: _currentPage,
          ),
          SizedBox(height: 16),
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

  const NavHitArea({
    super.key, 
    required this.isLeft, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: context.responsive(40, 60), 
        height: context.responsive(220, 300), 
        // color: Colors.red,
        alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(0, context.responsive(-4, -6)),
          child: Icon(
            isLeft ? AppIcons.navBack : AppIcons.navForward,
            color: AppColors.onSurfaceVariant,
            size: context.r(32),
          ),
        ),
      ),
    );
  }
}