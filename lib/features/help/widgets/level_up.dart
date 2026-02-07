import 'package:uniordle/shared/exports/help_exports.dart';

class LevelUp extends StatelessWidget {
  const LevelUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText(
          'LEVEL UP & UNLOCK',
          style: AppFonts.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: context.autoText(
            'Guess words to earn merits. Level up with merits, and gain credits.',
            style: AppFonts.labelMedium.copyWith(
              color: AppColorsDark.onSurfaceVariant,
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
                  AppIcons.gameMerit,
                  color: AppColorsDark.accent,
                  size: 24,
                ),
                color: context.surfaceVariant,
                title: 'Earn Merits',
                subtitle: 'EVERY CORRECT GUESS & LEVEL UP',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(
                  AppIcons.gameCredit,
                  color: AppColorsDark.correctColor,
                  size: 24,
                ),
                color: context.surfaceVariant,
                title: 'Earn Credits',
                subtitle: 'EVERY 5 LVLS TO UNLOCK MAJORS',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: context.autoIcon(
                  AppIcons.statMastered,
                  color: AppColorsDark.accent3,
                  size: 24,
                ),
                color: context.surfaceVariant,
                title: 'Ultimate Reward',
                subtitle: 'MASTER EVERY MAJOR',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
