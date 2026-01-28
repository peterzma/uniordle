import 'package:uniordle/shared/exports/stats_exports.dart';

class DistributionBar extends StatelessWidget {
  final String label;
  final int count;
  final double progress;
  final bool isHighest;

  const DistributionBar({
    super.key,
    required this.label,
    required this.count,
    required this.progress,
    required this.isHighest,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text(
              label,
              style: AppFonts.labelSmall.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = (constraints.maxWidth * progress).clamp(25.0, constraints.maxWidth);

                return Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // Animated bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutQuart,
                      height: 24,
                      width: barWidth,
                      alignment: count == 0 ? Alignment.center : Alignment.centerRight,
                      padding: EdgeInsets.only(right: count == 0 ? 0 : 12),
                      decoration: BoxDecoration(
                        color: isHighest ? AppColors.accent : AppColors.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "$count",
                        style: AppFonts.labelSmall.copyWith(color: AppColors.onSurface),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}