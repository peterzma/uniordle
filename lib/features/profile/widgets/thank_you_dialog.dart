import 'package:confetti/confetti.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/app_exports.dart';

class ThankYouDialog extends StatefulWidget {
  const ThankYouDialog({super.key});

  @override
  State<ThankYouDialog> createState() => _ThankYouDialogState();
}

class _ThankYouDialogState extends State<ThankYouDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            context.autoIcon(AppIcons.thankYou, size: 64, color: Colors.orange),
            SizedBox(height: context.r(16)),
            context.autoText("COMMENCEMENT", style: AppFonts.headline),
            SizedBox(height: context.r(12)),
            context.autoText(
              "Congratulations, Graduate! You've reached the highest rank in Uniordle. But can you master all the majors?",
              style: AppFonts.labelMedium,
              maxLines: 3,
            ),
            SizedBox(height: context.r(32)),
            PrimaryButton(
              label: 'The pleasure was mine',
              color: Colors.orange,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),

        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [Colors.orange, AppColors.accent, Colors.white, Colors.red],
          minimumSize: const Size(5, 5),
          maximumSize: const Size(10, 10),
        ),
      ],
    );
  }
}