import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserStats>(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {

        final int dBonus = stats.unlockedIds.length * 5;
        final int rBonus = (stats.currentLevel ~/ 10) * 5;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              const ProfileHeader(),

              const SizedBox(height: 16),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ACADEMIC PROGRESS",
                  style: AppFonts.headline,
                ),
              ),
        
              const SizedBox(height: 8),
        
              LevelCard(
                level: stats.currentLevel,
                progress: stats.levelProgress,
                nextLevel: stats.nextLevel,
                progressLabel: stats.progressText,
              ),
        
              const SizedBox(height: 16),
        

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SummaryCard(
                        label: "Discipline Bonus",
                        value: "+$dBonus%",
                        icon: LucideIcons.graduationCap,
                        iconColor: dBonus > 0 ? AppColors.correctColor : AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: SummaryCard(
                        label: "Total Merit",
                        value: '${stats.merit}',
                        icon: AppIcons.merits,
                        iconColor: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: SummaryCard(
                        label: "Rank Bonus",
                        value: "+$rBonus%",
                        icon: LucideIcons.award,
                        iconColor: rBonus > 0 ? Colors.orange : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
        
              const SizedBox(height: 16),

              RankPathway(currentLevel: stats.currentLevel),

              const SizedBox(height: 16),
            ],
          ),
        );
      }
    );
  }
}