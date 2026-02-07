import 'package:uniordle/shared/exports/post_game_exports.dart';

class MilestoneCelebrationDialog extends StatelessWidget {
  final MilestoneType type;
  final int level;

  const MilestoneCelebrationDialog({
    super.key,
    required this.type,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final stats = statsManager.statsNotifier.value;
    final bool isRank = type == MilestoneType.rankUp;

    final bool hasMoreMajors = stats.unlockedIds.length < MajorsData.all.length;
    final bool isUnderBonusCap = level <= 100;

    final String currentTitle = UserStats(
      streak: 0,
      solved: 0,
      merit: level * UserStats.meritPerLevel,
    ).academicTitle;

    String rankTitle;
    if (isRank) {
      rankTitle = isUnderBonusCap ? "RANK UP" : "ARCHIVAL MASTERY";
    } else {
      rankTitle = "CREDIT EARNED";
    }

    String description = "";
    if (isRank) {
      description = isUnderBonusCap
          ? "You've reached Level $level and gained a permanent +10% Rank Bonus!"
          : "You've reached Level $level! Your prestige as $currentTitle grows across the archives.";
    } else {
      description = hasMoreMajors
          ? "Level $level reached! You've earned a Credit to enroll in a new Major."
          : "Level $level reached! Use your extra Credit for Bonus Research.";
    }

    return BaseDialog(
      blur: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRank
                ? (isUnderBonusCap ? AppIcons.statRank : AppIcons.badgeOracle)
                : AppIcons.gameCredit,
            color: isRank
                ? context.colorScheme.tertiary
                : context.gameColors.correct,
            size: context.r(64),
          ),

          SizedBox(height: context.r(16)),

          context.autoText(rankTitle, style: AppFonts.headlineMedium),

          if (isRank) ...[
            context.autoText(
              currentTitle,
              style: AppFonts.headlineMedium.copyWith(
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],

          SizedBox(height: context.r(16)),

          context.autoText(
            description,
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 3,
          ),

          SizedBox(height: context.r(32)),

          PrimaryButton(
            label: "COLLECT",
            color: isRank
                ? context.colorScheme.tertiary
                : context.colorScheme.primary,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
