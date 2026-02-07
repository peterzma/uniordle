import 'package:uniordle/shared/exports/stats_exports.dart';

class ModeAnalyticsChart extends StatelessWidget {
  final Map<String, int> modeFrequency;

  const ModeAnalyticsChart({super.key, required this.modeFrequency});

  @override
  Widget build(BuildContext context) {
    final maxUsage = modeFrequency.values.isEmpty
        ? 1
        : modeFrequency.values.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        _buildHeaderRow(context),
        SizedBox(height: context.r(8)),
        ...[5, 6, 7].map((len) => _buildDataRow(context, len, maxUsage)),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 24),
        ...[8, 7, 6, 5].map(
          (tries) => Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$tries",
                  textAlign: TextAlign.center,
                  style: AppFonts.labelMedium.copyWith(
                    color: AppColorsDark.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: context.r(4)),
                Icon(
                  AppIcons.gameAttempts,
                  size: 12,
                  color: AppColorsDark.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataRow(BuildContext context, int length, int maxUsage) {
    return Row(
      children: [
        // Label Column (Word Length)
        SizedBox(
          width: 24,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$length", style: AppFonts.labelMedium),
              SizedBox(width: context.r(4)),
              Transform.translate(
                offset: const Offset(0, 1),
                child: Icon(
                  AppIcons.gameLetters,
                  size: 12,
                  color: AppColorsDark.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        // Heat Map Cells
        ...[8, 7, 6, 5].map((tries) {
          final count = modeFrequency["$length-$tries"] ?? 0;
          final bool isEmpty = count == 0;

          final Color cellColor = isEmpty
              ? context.surfaceVariant
              : AppColorsDark.accent.withValues(
                  alpha: (count / maxUsage).clamp(0.1, 1.0),
                );

          return Expanded(
            child: Container(
              height: 32,
              margin: EdgeInsets.all(context.r(4)),
              decoration: BoxDecoration(
                color: cellColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  count > 0 ? "$count" : "-",
                  style: AppFonts.labelSmall.copyWith(
                    color: !isEmpty && (count / maxUsage > 0.5)
                        ? AppColorsDark.onSurface
                        : AppColorsDark.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
