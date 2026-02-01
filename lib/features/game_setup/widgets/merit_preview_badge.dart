import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class MeritPreviewBadge extends StatelessWidget {
  final int difficulty;
  final int wordLength;
  final Major major;

  const MeritPreviewBadge({
    super.key,
    required this.difficulty,
    required this.wordLength,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    final bool mobileMode = AppLayout.mobileMode(context);

    return ValueListenableBuilder<UserStats>(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final ranges = UserStatsRewards.getMeritRange(stats, difficulty, wordLength);
      
        final bool hasBonus = stats.meritMultiplier > 1.0;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: major.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 2,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(AppIcons.merits, size: 16, color: major.color),
                    const SizedBox(width: 8),
                    Text(
                      mobileMode? "MERITS: " : "POTENTIAL MERITS: ",
                      style: AppFonts.labelLarge.copyWith(color: major.color),
                    ),
                  ],
                ),
                
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ranges.original,
                      style: AppFonts.labelLarge.copyWith(
                        color: hasBonus
                            ? major.color.withValues(alpha: 0.5) 
                            : major.color,
                        fontWeight: hasBonus ? FontWeight.normal : FontWeight.bold,
                        decoration: hasBonus ? TextDecoration.lineThrough : null,
                      ),
                    ),
            
                    if (hasBonus) ...[
                      const SizedBox(width: 6),
                      Icon(
                        LucideIcons.arrowRight, 
                        size: 14, 
                        color: major.color.withValues(alpha: 0.7)
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ranges.boosted,
                        style: AppFonts.labelLarge.copyWith(
                          color: major.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}