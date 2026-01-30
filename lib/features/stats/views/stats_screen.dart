import 'package:uniordle/features/stats/widgets/academic.dart/academic_history.dart';
import 'package:uniordle/features/stats/widgets/mode_analytics_chart.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';
import 'package:uniordle/shared/exports/stats_exports.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        final Color winColor = Color.lerp(AppColors.accent2, AppColors.correctColor, normalizedValue)!;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppLayout.sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    AutoSizeText("Academic Performance", style: AppFonts.displayLarge, maxLines: 1),
                    const SizedBox(height: AppLayout.titleToSubtitle),
                    Text("Your learning journey analytics", textAlign: TextAlign.center, style: AppFonts.labelMedium),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              
              const SizedBox(height: AppLayout.badgeToContent),

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: StatCard(value: "${stats.totalGames}", label: "Total\nGames")),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: stats.winPercentage, label: "Win\n%", color: winColor)),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: "${stats.streak}", label: "Current\nStreak", color: Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(value: "${stats.maxStreak}", label: "Best\nStreak", color: Colors.deepOrange)),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),

              Text(
                "CORRECT GUESSES", 
                style: AppFonts.labelLarge
              ),

              const SizedBox(height: 12),

              GuessDistributionChart(distribution: stats.guessDistribution),
              
              const SizedBox(height: 16),

              Text(
                "GAMES PLAYED", 
                style: AppFonts.labelLarge
              ),

              const SizedBox(height: 12),

              // This Heatmap-style grid shows Word Length vs Max Attempts
              ModeAnalyticsChart(modeFrequency: stats.modeFrequency),

              const SizedBox(height: 24),
              AcademicHistory(stats: stats),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}