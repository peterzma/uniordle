import 'package:uniordle/features/profile/widgets/profile_level.dart';
import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
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
                      icon: Icons.local_fire_department,
                      iconColor: Colors.orange,
                    )
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SummaryCard(
                      label: "Solved", 
                      value: '${stats.solved}',
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