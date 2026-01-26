import 'package:uniordle/shared/exports/help_exports.dart';

class HowToPlaySlide extends StatelessWidget {
  const HowToPlaySlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('HOW TO PLAY', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          'Choose a category, customise your settings, then guess the word!',
          style: AppFonts.labelMedium.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
            const InstructionRow(letter: 'U', color: AppColors.correctColor, title: 'Correct Letter', subtitle: 'Right spot'),
            const SizedBox(height: 32),
            const InstructionRow(letter: 'N', color: AppColors.inWordColor, title: 'Correct Letter', subtitle: 'Wrong spot'),
            const SizedBox(height: 32),
            const InstructionRow(letter: 'I', color: AppColors.notInWordColor, title: 'Letter not in word', subtitle: 'Not in any spot'),
            ]
          ),
        ),
      ],
    );
  }
}