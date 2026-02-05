import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final String academicTitle = stats.academicTitle;

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
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.surfaceVariant,
                        child: Icon(AppIcons.defaultProfile,
                            size: 48, color: AppColors.onSurfaceVariant),
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
                color: academicTitle == "THE ORACLE" ? Colors.amber : AppColors.accent,
                fontWeight: FontWeight.bold,
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
                    icon: LucideIcons.trophy,
                    label: "+${(summitBonus * 100).toInt()}%",
                    color: Colors.amber,
                  ),
                if (hasMastery)
                  _buildBadge(
                    context: context,
                    icon: AppIcons.completionist,
                    label: "+${(masteryBonus * 100).toInt()}%",
                    color: Colors.orange,
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
    required Color color
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
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