import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              ProfileHeader(),
        
              const SizedBox(height: 32),
        
              LevelCard(
                level: stats.currentLevel,
                progress: stats.levelProgress,
                nextLevel: stats.nextLevel,
                progressLabel: stats.progressText,
              ),
        
              const SizedBox(height: 16),
        
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      label: "Streak", 
                      value: '${stats.streak}',
                      icon: AppIcons.streak,
                      iconColor: Colors.orange,
                    )
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      label: "Solved", 
                      value: '${stats.solved}',
                      icon: AppIcons.solved,
                      iconColor: AppColors.accent,
                    )
                  ),
                ],
              ),
        
              const SizedBox(height: 32),

              RankPathway(currentLevel: stats.currentLevel),

              const SizedBox(height: 32),
            ],
          ),
        );
      }
    );
  }
}