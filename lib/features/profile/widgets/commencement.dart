import 'package:confetti/confetti.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/app_exports.dart';

class Commencement extends StatefulWidget {
  const Commencement({super.key});

  @override
  State<Commencement> createState() => _CommencementState();
}

class _CommencementState extends State<Commencement> {
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
              "Congratulations, Oracle! You've reached the summit of knowledge. Level 100 is yours, but true prestige lies in the archives. Can you master every single major?",
              textAlign: TextAlign.center,
              style: AppFonts.labelMedium,
              maxLines: 4,
            ),
              SizedBox(height: context.r(32)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    context.autoText(
                      "SUMMIT CONFERMENT",
                      style: AppFonts.labelSmall.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    context.autoText(
                      "+100% PERMANENT MERIT",
                      style: AppFonts.headline.copyWith(color: Colors.amber, fontSize: 20),
                      reduction: 8,
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: context.r(32)),
            PrimaryButton(
              label: 'I am ready',
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