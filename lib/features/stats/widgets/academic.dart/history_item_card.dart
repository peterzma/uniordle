import 'package:uniordle/shared/data/major_colors.dart';
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
    final String majorId = game['majorId'] ?? 'engineering';

    final grade = GameGrade.calculate(won, attempts, maxAttempts);
    final major = MajorsData.getById(majorId);
    final majorColors = Theme.of(context).extension<MajorColors>();
    final Color majorColor =
        majorColors?.map[majorId] ?? context.colorScheme.primary;

    return Container(
      margin: EdgeInsets.symmetric(vertical: context.r(4)),
      padding: EdgeInsets.all(context.r(AppLayout.cardPadding)),
      decoration: BoxDecoration(
        color: context.getGradeColor(grade).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppLayout.cardRounding),
      ),
      child: Row(
        children: [
          context.autoIcon(major.icon, size: 24, color: majorColor),
          SizedBox(width: context.r(8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.autoText(
                  word.toUpperCase(),
                  style: context.labelLarge,
                  textAlign: TextAlign.left,
                ),
                context.autoText(
                  "${major.name.toUpperCase()} - ${won ? '$attempts/$maxAttempts' : 'X/$maxAttempts'} ATTEMPTS",
                  style: context.labelSmall.copyWith(
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
                style: context.labelSmall.copyWith(
                  color: context.getGradeColor(grade),
                ),
              ),
              context.autoText(
                won ? "+$merit MERITS" : "$merit MERITS",
                style: context.labelSmall.copyWith(
                  color: context.getGradeColor(grade),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
