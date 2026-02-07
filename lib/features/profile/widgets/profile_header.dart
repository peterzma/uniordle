import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final String academicTitle = stats.academicTitle;
        final int level = stats.currentLevel;
        final double transitionPower = (level / 100).clamp(0.0, 1.0);

        final Color themeColor = Color.lerp(
          AppColorsDark.accent,
          AppColorsDark.accent4,
          transitionPower,
        )!;

        final bool isOracle = level >= 100;

        final double masteryBonus = stats.masteryBonusValue;
        final double summitBonus = stats.summitBonusValue;

        final bool hasMastery = masteryBonus > 0;
        final bool hasSummit = summitBonus > 0;

        // TEST MODE TOGGLES
        // 1. Uncomment below to force Chancellor's List badge
        // final bool unlockedAllMajors = true;
        // 2. Uncomment below to force the final rank level
        // final String academicTitle = "THE ORACLE";

        return Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                      boxShadow: isOracle
                          ? [
                              BoxShadow(
                                color: themeColor.withValues(
                                  alpha: 0.2 + (0.3 * transitionPower),
                                ),
                                blurRadius: 10 + (10 * transitionPower),
                                spreadRadius: 2 * transitionPower,
                              ),
                            ]
                          : null,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.surface,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: context.surfaceVariant,
                        child: Icon(
                          AppIcons.profileDefault,
                          size: 48,
                          color: AppColorsDark.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            context.autoText("Temp Name", style: AppFonts.displayLarge),

            context.autoText(
              academicTitle,
              style: AppFonts.labelLarge.copyWith(
                color: themeColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: context.r(4)),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (hasSummit)
                  _buildBadge(
                    context: context,
                    icon: AppIcons.badgeOracle,
                    label: "+${(summitBonus * 100).toInt()}%",
                    color: AppColorsDark.accent4,
                  ),
                if (hasMastery)
                  _buildBadge(
                    context: context,
                    icon: AppIcons.badgeMastery,
                    label: "+${(masteryBonus * 100).toInt()}%",
                    color: AppColorsDark.accent3,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          context.autoText(
            label,
            style: AppFonts.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
