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

        final int dBonus = ((stats.unlockedIds.length - 1).clamp(0, 99)) * 5;
        final int rBonus = (stats.currentLevel ~/ 10) * 10;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppLayout.pagePadding),
          child: Column(
            children: [
              const ProfileHeader(),

              const SizedBox(height: 16),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Academic Progress",
                  style: AppFonts.labelLarge,
                ),
              ),
        
              const SizedBox(height: 8),
        
              LevelCard(
                level: stats.currentLevel,
                progress: stats.levelProgress,
                nextLevel: stats.nextLevel,
                progressLabel: stats.progressText,
              ),
        
              SizedBox(height: context.r(16)),

              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SummaryCard(
                        label: "Major Bonus",
                        value: "+$dBonus%",
                        icon: LucideIcons.graduationCap,
                        iconColor: dBonus > 0 ? AppColors.correctColor : AppColors.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: context.r(16)),

                    Expanded(
                      child: SummaryCard(
                        label: "Total Merit",
                        value: '${stats.merit}',
                        icon: AppIcons.merits,
                        iconColor: AppColors.accent,
                      ),
                    ),

                    SizedBox(width: context.r(16)),

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
        
              SizedBox(height: context.r(16)),

              RankPathway(currentLevel: stats.currentLevel),
            ],
          ),
        );
      }
    );
  }
}