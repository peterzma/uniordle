import 'package:uniordle/features/stats/widgets/academic.dart/history_item_card.dart';
import 'package:uniordle/features/stats/widgets/academic.dart/academic_transcript_content.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/base_show_dialog.dart';

class AcademicHistory extends StatelessWidget {
  final UserStats stats;

  const AcademicHistory({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    // Show only the 3 most recent games (latest first)
    final recentGames = stats.gameHistory.reversed.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Academic Record", style: AppFonts.headline),
            if (stats.gameHistory.length > 3)
              TextButton(
                onPressed: () {
                  baseShowDialog(
                    context: context,
                    child: AcademicTranscriptContent(stats: stats),
                  );
                },
                child: Text(
                  "VIEW ALL",
                  style: AppFonts.labelSmall.copyWith(color: AppColors.accent),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (recentGames.isEmpty)
          _buildEmptyHistory()
        else
          ...recentGames.map((game) => HistoryItemCard(game: game)),
      ],
    );
  }

  Widget _buildEmptyHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.onSurface.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(LucideIcons.scrollText, color: AppColors.onSurfaceVariant, size: 32),
          const SizedBox(height: 8),
          Text(
            "No academic records found.\nComplete a game to start your transcript.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}