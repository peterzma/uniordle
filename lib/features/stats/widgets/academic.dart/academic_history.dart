import 'package:uniordle/features/stats/widgets/academic.dart/history_item_card.dart';
import 'package:uniordle/features/stats/widgets/academic.dart/academic_transcript_content.dart';
import 'package:uniordle/shared/buttons/simple_button.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/show_base_dialog.dart';

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
            context.autoText("Transcript", style: AppFonts.labelLarge),
            if (stats.gameHistory.length > 3)
              SimpleButton(
                text: "VIEW ALL",
                onTap: () => showBaseDialog(
                  context: context,
                  barrierDismissible: true,
                  child: AcademicTranscriptContent(stats: stats),
                ),
              ),
          ],
        ),
        SizedBox(height: context.r(8)),
        if (recentGames.isEmpty)
          _buildEmptyHistory(context)
        else
          ...recentGames.map((game) => HistoryItemCard(game: game)),
      ],
    );
  }

  Widget _buildEmptyHistory(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.r(AppLayout.cardPadding)),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          context.autoIcon(LucideIcons.scrollText, color: AppColors.onSurfaceVariant, size: 32),
          // SizedBox(height: 8),
          context.autoText(
            "No academic records found.\nComplete a game to start your transcript.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 2
          ),
        ],
      ),
    );
  }
}