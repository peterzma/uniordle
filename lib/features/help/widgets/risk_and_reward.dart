import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class RiskAndReward extends StatelessWidget {
  const RiskAndReward({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText('RISK & REWARD', style: AppFonts.headline, textAlign: TextAlign.center),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: context.autoText(
            'Higher ranks bring bigger challenges. \n Don\'t give up!',
            style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),

        SizedBox(height: 32),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              InstructionRow(
                leading: context.autoIcon(AppIcons.statLossPenalty, color: AppColors.accent2, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Tough Break',
                subtitle: 'LOSE MERITS ON FAILING',
              ),
              SizedBox(height: context.r(64)),
              InstructionRow(
                leading: context.autoIcon(LucideIcons.ghost, color: Colors.orange, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Ghosting Penalty',
                subtitle: 'QUITTING EARLY COSTS EXTRA',
              ),
            ]
          ),
        ),
      ],
    );
  }
}