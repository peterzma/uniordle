import 'package:confetti/confetti.dart';
import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/app_exports.dart';

class Ascension extends StatefulWidget {
  const Ascension({super.key});

  @override
  State<Ascension> createState() => _AscensionState();
}

class _AscensionState extends State<Ascension> {
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
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        final String dynamicBonus = "+${(stats.masteryBonusValue * 100).toInt()}%";
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.autoIcon(AppIcons.badgeMastery, size: 64, color: AppColors.accent3),
                SizedBox(height: context.r(16)),
                context.autoText("ASCENSION", style: AppFonts.headline),
                SizedBox(height: context.r(12)),
                context.autoText(
                  "You have done it, Oracle. Every major mastered, every archive opened. You have transcended the university and reached the end of the path. Well Done.",
                  textAlign: TextAlign.center,
                  style: AppFonts.labelMedium,
                  maxLines: 4,
                ),
                SizedBox(height: context.r(32)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accent3.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    children: [
                      context.autoText(
                        "THE ORACLE'S LEGACY",
                        style: AppFonts.labelSmall.copyWith(color: AppColors.accent3, fontWeight: FontWeight.bold),
                      ),
                      context.autoText(
                        "$dynamicBonus PERMANENT MERIT",
                        style: AppFonts.headline.copyWith(color: AppColors.accent3, fontSize: 20),
                        reduction: 8,
                      ),
                    ],
                  ),
                ),
        
                SizedBox(height: context.r(32)),
                PrimaryButton(
                  label: 'So it is written',
                  color: AppColors.accent3,
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
    );
  }
}