import 'package:uniordle/shared/exports/stats_exports.dart';

class HistoryItemCard extends StatelessWidget {
  final Map<String, dynamic> game;
  const HistoryItemCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final bool won = game['won'] ?? true;
    final int attempts = game['attempts'] ?? 0;
    final int maxAttempts = game['maxAttempts'] ?? 8;
    final int merit = game['merit'] ?? 0;
    final String word = game['word'] ?? "?????";

    final grade = GameGrade.calculate(won, attempts, maxAttempts);

    return Container(
      margin: EdgeInsets.symmetric(vertical: context.r(4)),
      padding: EdgeInsets.all(context.r(AppLayout.cardPadding)),
      decoration: BoxDecoration(
        color: context.getGradeColor(grade).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.r(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.autoText(
                  word.toUpperCase(),
                  style: AppFonts.labelLarge,
                  textAlign: TextAlign.left,
                ),
                context.autoText(
                  won
                      ? "$attempts/$maxAttempts ATTEMPTS"
                      : "X/$maxAttempts ATTEMPTS",
                  style: AppFonts.labelSmall.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              context.autoText(
                grade.label,
                style: AppFonts.labelSmall.copyWith(
                  color: context.getGradeColor(grade),
                ),
              ),
              context.autoText(
                won ? "+$merit MERITS" : "$merit MERITS",
                style: AppFonts.labelSmall.copyWith(
                  color: won
                      ? AppColorsDark.correctColor
                      : AppColorsDark.accent2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
