import 'package:uniordle/shared/exports/help_exports.dart';

class StakesAndPenalties extends StatelessWidget {
  const StakesAndPenalties({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText(
          'STAKES & PENALTIES',
          style: AppFonts.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: context.autoText(
            'Higher ranks bring bigger challenges. \n Don\'t give up!',
            style: AppFonts.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
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
                leading: context.autoIcon(
                  AppIcons.statLossPenalty,
                  color: AppColors.accent2,
                  size: 24,
                ),
                color: AppColors.surfaceVariant,
                title: 'Fail Penalty',
                subtitle: 'LOSE MERITS ON FAILING',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(
                  AppIcons.statAbandonCost,
                  color: AppColors.onSurface,
                  size: 24,
                ),
                color: AppColors.surfaceVariant,
                title: 'Abandon Cost',
                subtitle: 'QUITTING EARLY COSTS EXTRA',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(
                  AppIcons.gameHistory,
                  color: AppColors.accent,
                  size: 24,
                ),
                color: AppColors.surfaceVariant,
                title: 'Transcript',
                subtitle: 'GRADES ARE BASED ON ATTEMPTS',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
