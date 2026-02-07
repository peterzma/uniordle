import 'package:uniordle/shared/exports/post_game_exports.dart';

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
    final grade = GameGrade.calculate(won, attempts, maxAttempts);

    return Container(
      padding: EdgeInsets.all(AppLayout.cardPadding),
      decoration: BoxDecoration(
        color: context.getGradeColor(grade).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppLayout.cardRounding),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.autoText(
                grade.label,
                style: AppFonts.labelSmall.copyWith(
                  color: context.getGradeColor(grade),
                ),
              ),
              context.autoText(
                won
                    ? "$attempts/$maxAttempts ATTEMPTS"
                    : "X/$maxAttempts ATTEMPTS",
                style: AppFonts.labelSmall.copyWith(
                  color: context.getGradeColor(grade),
                ),
              ),
            ],
          ),
          SizedBox(height: context.r(8)),
          Builder(
            builder: (context) {
              final double baseSize = AppFonts.labelSmall.fontSize ?? 12;
              final double responsiveSize = context.responsive(
                baseSize - 2,
                baseSize,
              );

              final bool isPositive = gainedMerit >= 0;
              final String amount = gainedMerit.toInt().abs().toString();
              final String unit = isPositive ? "merits" : "demerits";

              final Color normalColor = isPositive
                  ? context.colorScheme.onSurfaceVariant
                  : context.colorScheme.error.withValues(alpha: 0.8);

              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppFonts.labelSmall.copyWith(
                    fontSize: responsiveSize,
                    color: normalColor,
                  ),
                  children: [
                    TextSpan(
                      text: isPositive ? "You earned " : "You received ",
                    ),
                    TextSpan(
                      text: amount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.getGradeColor(grade),
                      ),
                    ),
                    const TextSpan(text: " "),
                    TextSpan(
                      text: unit,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.getGradeColor(grade),
                      ),
                    ),
                    TextSpan(
                      text: isPositive
                          ? " based on your attempts."
                          : " due to failing to guess correctly.",
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
