import 'package:uniordle/features/profile/controller/player_stats.dart';
import 'package:uniordle/features/profile/widgets/profile_level.dart';
import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        final int solvedCount = stats.solved;
        final int currentStreak = stats.streak;

        const int wordsPerLevel = 2;

        final int currentLevel = solvedCount ~/ wordsPerLevel;

        final double progressValue = (solvedCount % wordsPerLevel) / wordsPerLevel;

        final int nextLevel = currentLevel + 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              ProfileHeader(),
        
              const SizedBox(height: 32),
        
              LevelCard(
                level: currentLevel,
                progress: progressValue,
                nextLevel: nextLevel,
              ),
        
              const SizedBox(height: 16),
        
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      label: "Streak", 
                      value: '$currentStreak',
                      icon: Icons.local_fire_department,
                      iconColor: Colors.orange,
                    )
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      label: "Solved", 
                      value: '$solvedCount',
                      icon: Icons.check_circle_outline,
                      iconColor: AppColors.accent,
                    )
                  ),
                ],
              ),
        
              const SizedBox(height: 32),
        
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("UNLOCKED DISCIPLINES", style: AppTextStyles.labelLarge),
              //     TextButton(
              //       onPressed: () {}, 
              //       child: Text(
              //         "See All",
              //         style: AppTextStyles.labelSmall.copyWith(fontSize: 12)
              //       )
              //     ),
              //   ],
              // ),
        
              // GridView.count(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 12,
              //   crossAxisSpacing: 12,
              //   childAspectRatio: 2.2,
              //   children: const [
                  
              //   ],
              // ),
            ],
          ),
        );
      }
    );
  }
}