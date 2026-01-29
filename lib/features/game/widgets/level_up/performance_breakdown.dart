import 'package:uniordle/shared/exports/end_game_exports.dart';

class PerformanceBreakdown extends StatelessWidget {
  final bool won;
  final int attempts;
  final int maxAttempts;
  final double gainedMerit;

  const PerformanceBreakdown({
    super.key,
    required this.won,
    required this.attempts,
    required this.maxAttempts,
    required this.gainedMerit,
  });

  @override
  Widget build(BuildContext context) {
    final double weight = won
        ? (maxAttempts - attempts) / (maxAttempts - 1).toDouble()
        : 0.0;

    String performanceText;
    Color performanceColor;

    if (!won) {
      performanceText = "FAIL";
      performanceColor = AppColors.accent2;
    } else {
      if (weight >= 0.85) {
        performanceText = "HIGH DISTINCTION";
        performanceColor = AppColors.correctColor;
      } else if (weight >= 0.70) {
        performanceText = "DISTINCTION";
        performanceColor = AppColors.accent;
      } else if (weight >= 0.50) {
        performanceText = "CREDIT";
        performanceColor = Colors.orange;
      } else {
        performanceText = "PASS";
        performanceColor = Colors.blueGrey;
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: performanceColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: performanceColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                performanceText,
                style: AppFonts.labelSmall.copyWith(
                  color: performanceColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$attempts/$maxAttempts ATTEMPTS",
                style: AppFonts.labelSmall.copyWith(color: performanceColor),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            gainedMerit >= 0
                ? "You earned ${gainedMerit.toInt()} merits based on your number of attempts."
                : "You lost ${gainedMerit.toInt().abs()} merits due to failing to guess correctly.",
            style: AppFonts.labelSmall.copyWith(
              color: gainedMerit >= 0
                  ? AppColors.onSurfaceVariant
                  : AppColors.accent2.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}