import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class LevelUp extends StatelessWidget {
  const LevelUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('LEVEL UP & UNLOCK', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: AppLayout.titleToSubtitle),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Guess words correctly to earn '),
                TextSpan(
                  text: 'merits',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: '. Level up with merits, and gain a '),
                TextSpan(
                  text: 'credit ',
                  style: TextStyle(
                    color: AppColors.accent3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: 'every five levels.'),
              ],
            ),
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: context.r(24)),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              InstructionRow(
                leading: Icon(AppIcons.merits, color: AppColors.accent, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Earn Merits',
                subtitle: 'FOR EVERY CORRECT GUESS',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Icon(LucideIcons.trendingUp, color: Colors.green, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Customise',
                subtitle: 'HARDER SETTINGS = MORE MERITS',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Icon(AppIcons.credits, color: AppColors.accent3, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Use Credits',
                subtitle: 'UNLOCK NEW DISCIPLINES',
              ),
            ]
          ),
        ),
      ],
    );
  }
}