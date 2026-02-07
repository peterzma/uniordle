import 'package:uniordle/shared/exports/profile_exports.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final double progress;
  final int nextLevel;
  final String progressLabel;

  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.nextLevel,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppLayout.cardPadding),
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: BorderRadius.circular(AppLayout.cardRounding),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LevelInfo(label: "CURRENT", level: "Level $level"),
              _LevelInfo(
                label: "NEXT",
                level: "Level $nextLevel",
                crossAlign: CrossAxisAlignment.end,
              ),
            ],
          ),

          SizedBox(height: context.r(8)),

          // The Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: context.r(16),
              backgroundColor: context.colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.circular(64),
              valueColor: AlwaysStoppedAnimation<Color>(
                context.colorScheme.primary,
              ),
            ),
          ),

          SizedBox(height: context.r(8)),

          // X/Y SOLVES TO LEVEL Z Badge
          LayoutBuilder(
            builder: (context, constraints) {
              final double xTranslation = -progress;

              return Stack(
                children: [
                  SizedBox(height: context.r(40), width: double.infinity),
                  Positioned(
                    left: progress * constraints.maxWidth,
                    child: FractionalTranslation(
                      translation: Offset(xTranslation, 0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.r(8),
                          vertical: context.r(4),
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: context.autoText(
                          progressLabel,
                          style: AppFonts.labelSmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LevelInfo extends StatelessWidget {
  final String label, level;
  final CrossAxisAlignment crossAlign;
  const _LevelInfo({
    required this.label,
    required this.level,
    this.crossAlign = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        context.autoText(
          label,
          style: AppFonts.labelSmall.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        context.autoText(level, style: AppFonts.headlineMedium, reduction: 8),
      ],
    );
  }
}
