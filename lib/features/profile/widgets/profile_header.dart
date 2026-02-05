import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/features/home/data/major_data.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final String academicTitle = stats.academicTitle;
        final bool unlockedAllMajors = stats.masteredCount >= MajorsData.all.length;

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
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.autoText(
                  academicTitle,
                  style: AppFonts.labelLarge.copyWith(
                    color: academicTitle == "THE ORACLE" ? Colors.amber : AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (unlockedAllMajors) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.amber.withValues(alpha: 0.3), width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(AppIcons.mastered, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        context.autoText(
                          "+50%",
                          style: AppFonts.labelSmall.copyWith(
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }
}