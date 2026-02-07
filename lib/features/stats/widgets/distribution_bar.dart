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
          SizedBox(width: 20, child: Text(label, style: AppFonts.labelMedium)),
          SizedBox(width: context.r(8)),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = (constraints.maxWidth * progress).clamp(
                  24.0,
                  constraints.maxWidth,
                );

                return Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: context.surfaceVariant,
                        borderRadius: BorderRadius.circular(64),
                      ),
                    ),
                    // Animated bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                      height: 24,
                      width: barWidth,
                      alignment: count == 0
                          ? Alignment.center
                          : Alignment.centerRight,
                      padding: EdgeInsets.only(right: count == 0 ? 0 : 12),
                      decoration: BoxDecoration(
                        color: isHighest
                            ? AppColorsDark.accent
                            : AppColorsDark.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Text(
                        "$count",
                        style: AppFonts.labelSmall.copyWith(
                          color: AppColorsDark.onSurface,
                        ),
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
