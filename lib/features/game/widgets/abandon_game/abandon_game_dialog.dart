import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';

class AbandonGameDialog extends StatelessWidget {
  const AbandonGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final streak = statsManager.statsNotifier.value.streak;
    
    final highlightStyle = AppFonts.labelMedium.copyWith(
      color: AppColors.accent2,
    );

    return BaseDialog(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            AppIcons.abandonGame,
            color: AppColors.accent2,
            size: AppLayout.dialogIcon,
          ),
          const SizedBox(height: 16),
          Text(
            "ABANDON GAME?",
            style: AppFonts.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppLayout.titleToSubtitle),
          Text.rich(
            TextSpan(
              style: AppFonts.labelMedium,
              children: [
                const TextSpan(text: "Leaving early will result in a penalty of "),
                TextSpan(
                  text: "${UserStats.penaltyAmount} demerits",
                  style: highlightStyle,
                ),
                if (streak > 0) ...[
                  const TextSpan(text: " and the loss of your "),
                  TextSpan(
                    text: "$streak win streak",
                    style: highlightStyle,
                  ),
                ],
                const TextSpan(text: "."),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppLayout.gapToButton),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'CANCEL',
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(width: AppLayout.gapBetweenButtons),
              Expanded(
                child: PrimaryButton(
                  label: 'LEAVE',
                  color: AppColors.accent2,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => const AbandonGameDialog(),
    ) ?? false;
  }
}