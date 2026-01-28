import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final String academicTitle = stats.academicTitle;

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
                        child: Icon(AppIcons.defaultProfile, size: 48, color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Temp Name",
              style: AppFonts.displayMedium
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "Academic Rank: ", 
                style: AppFonts.labelMedium
                ),
                Text(
                  academicTitle, 
                style: AppFonts.labelLarge.copyWith(color: AppColors.accent)
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}