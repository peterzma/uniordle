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
        context.autoText('LEVEL UP & UNLOCK', style: AppFonts.headline, textAlign: TextAlign.center),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: context.autoText(
            'Guess words to earn merits. Level up with merits, and gain credits.',
            style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),

        SizedBox(height: context.r(32)),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              InstructionRow(
                leading: context.autoIcon(AppIcons.merits, color: AppColors.accent, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Earn Merits',
                subtitle: 'EVERY CORRECT GUESS',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(LucideIcons.trendingUp, color: Colors.green, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Level Up',
                subtitle: 'GAIN MERIT BONUSES',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(AppIcons.credits, color: AppColors.accent3, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Use Credits',
                subtitle: 'UNLOCK NEW MAJORS',
              ),
            ]
          ),
        ),
      ],
    );
  }
}