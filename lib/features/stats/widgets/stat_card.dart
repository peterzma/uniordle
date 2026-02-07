import 'package:uniordle/shared/exports/stats_exports.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.responsive(80, 120),
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: BorderRadius.circular(AppLayout.cardRounding),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.autoText(
            value,
            style: AppFonts.displayMedium.copyWith(color: color),
            reduction: 8,
          ),
          context.autoText(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: AppFonts.labelSmall.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
