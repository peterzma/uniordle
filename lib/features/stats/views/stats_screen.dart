import 'package:uniordle/features/stats/widgets/academic.dart/academic_history.dart';
import 'package:uniordle/features/stats/widgets/mode_analytics_chart.dart';
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
        final Color winColor = Color.lerp(AppColors.accent2, AppColors.correctColor, normalizedValue)!;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppLayout.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    context.autoText("Performance", style: AppFonts.displayLarge, maxLines: 1),
                    SizedBox(height: context.r(4)),
                    context.autoText("Your learning journey analytics", textAlign: TextAlign.center, style: AppFonts.labelMedium),
                    SizedBox(height: context.r(8)),
                  ],
                ),
              ),

              SizedBox(height: context.r(16)),

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: StatCard(value: "${stats.totalGames}", label: "Total\nGames")),
                    SizedBox(width: context.r(8)),
                    Expanded(child: StatCard(value: stats.winPercentage, label: "Win\nRate", color: winColor)),
                    SizedBox(width: context.r(8)),
                    Expanded(child: StatCard(value: "${stats.streak}", label: "Current\nStreak", color: Colors.orange)),
                    SizedBox(width: context.r(8)),
                    Expanded(child: StatCard(value: "${stats.maxStreak}", label: "Best\nStreak", color: Colors.deepOrange)),
                  ],
                ),
              ),
              
              SizedBox(height: context.r(16)),

              context.autoText(
                "Correct Guesses", 
                style: AppFonts.labelLarge
              ),

              SizedBox(height: context.r(8)),

              GuessDistributionChart(distribution: stats.guessDistribution),
              
              SizedBox(height: context.r(16)),

              context.autoText(
                "Games Played", 
                style: AppFonts.labelLarge
              ),

              SizedBox(height: context.r(8)),

              // This Heatmap-style grid shows Word Length vs Max Attempts
              ModeAnalyticsChart(modeFrequency: stats.modeFrequency),

              SizedBox(height: context.r(16)),
              AcademicHistory(stats: stats),
            ],
          ),
        );
      },
    );
  }
}