import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';
class MilestoneCelebrationDialog extends StatelessWidget {
  final MilestoneType type;
  final int level;

  const MilestoneCelebrationDialog({
    super.key, 
    required this.type, 
    required this.level
  });

  @override
  Widget build(BuildContext context) {
    final isRank = type == MilestoneType.rankUp;

    final String currentTitle = UserStats(
      streak: 0,
      solved: 0,
      merit: level * UserStats.meritPerLevel,
    ).academicTitle;
    
    return BaseDialog(
      blur: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (isRank ? AppColors.accent3 : AppColors.accent).withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Icon(
            isRank ? LucideIcons.graduationCap : AppIcons.credits,
            color: isRank ? AppColors.accent3 : AppColors.accent,
            size: context.r(80),
          ),
        ),
          
          SizedBox(height: context.r(32)),
      
          context.autoText(
            isRank ? "NEW RANK:" : "CREDIT EARNED!",
            style: AppFonts.headline,
          ),

          if (isRank) ...[
            context.autoText(
              currentTitle,
              style: AppFonts.headline.copyWith(
                color: AppColors.accent3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
      
          SizedBox(height: context.r(16)),
      
          context.autoText(
            isRank 
              ? "You've reached Level $level and gained a permanent +10% Rank Bonus!"
              : "Level $level reached! You can now enroll in a new Major.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 2
          ),
      
          SizedBox(height: context.r(32)),
      
          PrimaryButton(
            label: "COLLECT",
            color: isRank ? AppColors.accent3 : AppColors.accent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}