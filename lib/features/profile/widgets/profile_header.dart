import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(Icons.account_circle, size: 48, color: AppColors.onSurfaceVariant),
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
            "Academic Level: ", 
            style: AppFonts.labelMedium
            ),
            Text(
              "SENIOR", 
            style: AppFonts.labelLarge.copyWith(color: AppColors.accent)
            ),
          ],
        ),
      ],
    );
  }
}