import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText('HOW TO PLAY', style: AppFonts.headline, textAlign: TextAlign.center),
        SizedBox(height: context.r(8)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.minAppWidth),
          child: context.autoText(
            'Choose a starting major, customise your game settings and then guess the word!',
            style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),

        SizedBox(height: context.r(24)),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              InstructionRow(
                leading: Text('U', style: AppFonts.displayMedium),
                color: AppColors.correctColor,
                title: 'Correct Letter',
                subtitle: 'RIGHT SPOT',
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Text('N', style: AppFonts.displayMedium), 
                color: AppColors.inWordColor, 
                title: 'Correct Letter', 
                subtitle: 'WRONG SPOT'
              ),
              SizedBox(height: context.r(32)),
              InstructionRow(
                leading: Text('I', style: AppFonts.displayMedium), 
                color: AppColors.notInWordColor, 
                title: 'Wrong Letter', 
                subtitle: 'NO SPOT'
              ),
            ]
          ),
        ),
      ],
    );
  }
}