import 'package:uniordle/shared/exports/game_exports.dart';

class HistoryItemCard extends StatelessWidget {
  final Map<String, dynamic> game;

  const HistoryItemCard({required this.game});

  @override
  Widget build(BuildContext context) {
    final bool won = game['won'] ?? true;
    final int attempts = game['attempts'] ?? 0;
    final int maxAttempts = game['maxAttempts'] ?? 8;
    final int merit = game['merit'] ?? 0;
    final String word = game['word'] ?? "?????";

    // Your PerformanceBreakdown logic
    final double weight = won ? (maxAttempts - attempts) / (maxAttempts - 1).toDouble() : 0.0;
    
    String gradeText;
    Color gradeColor;

    if (!won) {
      gradeText = "FAIL";
      gradeColor = AppColors.accent2;
    } else if (weight >= 0.85) {
      gradeText = "HIGH DISTINCTION";
      gradeColor = AppColors.correctColor;
    } else if (weight >= 0.70) {
      gradeText = "DISTINCTION";
      gradeColor = AppColors.accent;
    } else if (weight >= 0.50) {
      gradeText = "CREDIT";
      gradeColor = Colors.orange;
    } else {
      gradeText = "PASS";
      gradeColor = Colors.blueGrey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: gradeColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gradeColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.toUpperCase(), 
                  style: AppFonts.labelLarge.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2)
                ),
                Text(
                  "$attempts/$maxAttempts ATTEMPTS", 
                  style: AppFonts.labelSmall.copyWith(color: AppColors.onSurfaceVariant)
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                gradeText, 
                style: AppFonts.labelSmall.copyWith(color: gradeColor, fontWeight: FontWeight.bold)
              ),
              Text(
                won ? "+$merit MERITS" : "$merit MERITS",
                style: AppFonts.labelSmall.copyWith(
                  color: won ? AppColors.correctColor : AppColors.accent2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}