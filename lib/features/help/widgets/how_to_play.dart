import 'package:uniordle/shared/exports/help_exports.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText(
          'HOW TO PLAY',
          style: context.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.minAppWidth),
          child: context.autoText(
            'Pick a starting major, choose your game settings and then guess the word!',
            style: context.labelMedium.copyWith(
              color: context.colorScheme.onSurfaceVariant,
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
                leading: Text('U', style: context.displayMedium),
                color: context.gameColors.correct,
                title: 'Correct Letter',
                subtitle: 'RIGHT SPOT',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Text('N', style: context.displayMedium),
                color: context.gameColors.inWord,
                title: 'Correct Letter',
                subtitle: 'WRONG SPOT',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Text('I', style: context.displayMedium),
                color: context.gameColors.notInWord,
                title: 'Wrong Letter',
                subtitle: 'NO SPOT',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
