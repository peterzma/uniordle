import 'package:uniordle/shared/exports/help_exports.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('HOW TO PLAY', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          'Choose a discipline. Customise your game settings. Guess the word!',
          style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
            InstructionRow(
              leading: Text('U', style: AppFonts.displayMedium),
              color: AppColors.correctColor,
              title: 'Correct Letter',
              subtitle: 'Right spot',
            ),
            const SizedBox(height: 32),
            InstructionRow(
              leading: Text('N', style: AppFonts.displayMedium), 
              color: AppColors.inWordColor, 
              title: 'Correct Letter', 
              subtitle: 'Wrong spot'
            ),
            const SizedBox(height: 32),
            InstructionRow(
              leading: Text('I', style: AppFonts.displayMedium), 
              color: AppColors.notInWordColor, 
              title: 'Letter not in word', 
              subtitle: 'Not in any spot'
            ),
            ]
          ),
        ),
      ],
    );
  }
}