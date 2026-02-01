import 'package:uniordle/shared/exports/app_exports.dart';
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
      padding: EdgeInsets.symmetric(vertical: context.r(4)),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text(
              label,
              style: AppFonts.labelMedium,
            ),
          ),
          const SizedBox(width: 8),
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
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    // Animated bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                      height: 24,
                      width: barWidth,
                      alignment: count == 0 ? Alignment.center : Alignment.centerRight,
                      padding: EdgeInsets.only(right: count == 0 ? 0 : 8),
                      decoration: BoxDecoration(
                        color: isHighest ? AppColors.accent : AppColors.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(64),
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