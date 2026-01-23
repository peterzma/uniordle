import 'package:uniordle/features/help/widgets/instruction_row.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/layout/base_dialog.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'HOW TO PLAY', 
              style: AppTextStyles.headline
            ),
            const SizedBox(height: 8),
            Text(
              'Guess the word in 5 to 8 tries.',
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            InstructionRow(letter: 'W', color: AppColors.correctColor, title: 'title', subtitle: 'subtitle'),
            const SizedBox(height: 16),
            InstructionRow(letter: 'I', color: AppColors.inWordColor, title: 'title', subtitle: 'subtitle'),
            const SizedBox(height: 16),
            InstructionRow(letter: 'N', color: AppColors.notInWordColor, title: 'title', subtitle: 'subtitle'),
            const SizedBox(height: 40),
            PrimaryButton(
              label: 'GOT IT',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      )
    );
  }
}