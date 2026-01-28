import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';
import 'package:uniordle/shared/exports/stats_exports.dart';

class StatsScreen extends StatelessWidget {

  const StatsScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserStats>(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final double winValue = double.tryParse(stats.winPercentage.replaceAll('%', '')) ?? 0;
        final double normalizedValue = (winValue / 100).clamp(0.0, 1.0);
        final Color winColor = Color.lerp(Colors.red, AppColors.correctColor, normalizedValue)!;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.kSidePadding, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Academic Performance",
                      style: AppFonts.displayLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Your learning journey analytics",
                      style: AppFonts.labelMedium,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(AppIcons.merits, color: AppColors.accent, size: 20),

                          const SizedBox(width: 12),
                          
                          Text(
                            "${stats.xp} TOTAL MERITS",
                            style: AppFonts.labelLarge.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: StatCard(value: "${stats.totalGames}", label: "Total\nGames")),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: stats.winPercentage, label: "Win\n%", color: winColor)),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: "${stats.maxStreak}", label: "Best\nStreak", color: Colors.orange)),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              Text(
                "CORRECT GUESS DISTRIBUTION", 
                style: AppFonts.labelMedium
              ),

              const SizedBox(height: 12),

              GuessDistributionChart(distribution: stats.guessDistribution),
              
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}