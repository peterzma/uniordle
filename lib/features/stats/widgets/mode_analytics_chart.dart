import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
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
        _buildHeaderRow(),
        const SizedBox(height: 8),
        ...[5, 6, 7].map((len) => _buildDataRow(context, len, maxUsage)),
      ],
    );
  }

  Widget _buildHeaderRow() {
      return Row(
        children: [
          const SizedBox(width: 40),
          ...[8, 7, 6, 5].map((tries) => Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$tries", 
                  textAlign: TextAlign.center, 
                  style: AppFonts.labelMedium.copyWith(
                    color: AppColors.onSurfaceVariant
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  AppIcons.attempts,
                  size: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          )),
        ],
      );
    }

  Widget _buildDataRow(BuildContext context, int length, int maxUsage) {
    return Row(
      children: [
        // Label Column (Word Length)
        SizedBox(
          width: 40, 
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$length", 
                style: AppFonts.labelMedium
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.text_fields_rounded,
                size: 12,
                color: AppColors.onSurfaceVariant,
              ),
            ],
          ),
        ),
        
        // Heat Map Cells
        ...[8, 7, 6, 5].map((tries) {
          final count = modeFrequency["$length-$tries"] ?? 0;
          final opacity = count == 0 ? 0.05 : (count / maxUsage).clamp(0.1, 1.0);
          
          return Expanded(
            child: Container(
              height: 30,
              margin: EdgeInsets.all(context.r(4)),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  count > 0 ? "$count" : "-", 
                  style: AppFonts.labelSmall.copyWith(
                    color: opacity > 0.5 ? AppColors.onSurface : AppColors.onSurfaceVariant,
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