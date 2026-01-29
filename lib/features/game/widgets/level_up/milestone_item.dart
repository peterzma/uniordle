import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';

class MilestoneItem extends StatelessWidget {
  final int level;

  const MilestoneItem({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final bool isRankUp = level % 10 == 0;
    final bool isCreditEarned = level % 5 == 0;
    final bool isCreditOnly = level % 5 == 0 && level % 10 != 0;

    final Color bgColor = isRankUp
        ? AppColors.accent3
        : (isCreditOnly ? AppColors.accent : AppColors.surfaceVariant);

    final Color contentColor = (isRankUp || isCreditEarned)
        ? AppColors.onSurface
        : AppColors.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            isRankUp
                ? LucideIcons.graduationCap
                : (isCreditOnly ? AppIcons.credits : AppIcons.merits),
            size: 20,
            color: contentColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getMilestoneTitle(level),
                  style: AppFonts.labelLarge.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getMilestoneSubtitle(level),
                  style: AppFonts.labelSmall.copyWith(
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMilestoneTitle(int level) {
    if (level % 10 == 0) return "RANK UP & CREDIT +1";
    if (level % 5 == 0 && level <= 70) return "CREDIT +1";
    return "LEVEL UP!";
  }

  String _getMilestoneSubtitle(int level) {
    if (level % 10 == 0) {
      final String rank = UserStats(
        streak: 0,
        solved: 0,
        merit: level * UserStats.meritPerLevel,
      ).academicTitle;
      final int rankBonus = (level ~/ 10) * 10;
      return "Promoted to $rank! Permanent +$rankBonus% Rank Bonus reached.";
    }
    if (level % 5 == 0) return "Credit Earned! Check the Home screen to enroll in a new Discipline.";
    return "You have reached LEVEL $level";
  }
}