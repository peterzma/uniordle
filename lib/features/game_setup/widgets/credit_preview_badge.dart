import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/services/models/user_stats.dart';

class CreditPreviewBadge extends StatelessWidget {
  final int difficulty;
  final int wordLength;
  final Discipline discipline;

  const CreditPreviewBadge({
    super.key,
    required this.difficulty,
    required this.wordLength,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: discipline.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.merits, 
            size: 16, 
            color: discipline.color
          ),
          const SizedBox(width: 8),
          Text(
            "POTENTIAL MERITS: ",
            style: AppFonts.labelLarge.copyWith(
              color: discipline.color,
            ),
          ),
          Text(
            UserStatsRewards.getMeritRange(difficulty, wordLength),
            style: AppFonts.labelLarge.copyWith(
              color: discipline.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}