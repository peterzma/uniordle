import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/layout/base_badge.dart';

class HomeHero extends StatelessWidget {
  final UserStats stats;

  const HomeHero({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final bool hasCredits = stats.availableCredits > 0;
    final Color statusColor = hasCredits
        ? AppColors.accent3
        : AppColors.onSurfaceVariant.withValues(alpha: 0.5);

    return Column(
      children: [
        context.autoText(
          'Select a Major',
          style: AppFonts.displayLarge,
          maxLines: 1,
        ),
        SizedBox(height: context.r(4)),
        context.autoText(
          'Master your academic vocabulary.',
          textAlign: TextAlign.center,
          style: AppFonts.labelMedium,
        ),
        SizedBox(height: context.r(16)),
        SelectButtonWrapper(
          onTap: () => _showUseCreditsDialog(context),
          child: hasCredits
              ? PulsingButtonWrapper(
                  glowColor: statusColor,
                  child: _buildBadge(statusColor),
                )
              : _buildBadge(statusColor),
        ),
      ],
    );
  }

  void _showUseCreditsDialog(BuildContext context) {
    showBaseDialog(
      context: context,
      child: UseCredits(
        credits: stats.availableCredits,
        nextLevel: stats.nextCreditAtLevel,
      ),
    );
  }

  Widget _buildBadge(Color statusColor) {
    return BaseBadge(
      label:
          "${stats.availableCredits} ${stats.availableCredits == 1 ? 'CREDIT' : 'CREDITS'}",
      icon: AppIcons.gameCredit,
      color: statusColor,
    );
  }
}
