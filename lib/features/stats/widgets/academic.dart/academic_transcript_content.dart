import 'package:uniordle/features/stats/widgets/academic.dart/history_item_card.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class AcademicTranscriptContent extends StatelessWidget {
  final UserStats stats;

  const AcademicTranscriptContent({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final allGames = stats.gameHistory.reversed.toList();

    return Column(
      mainAxisSize: MainAxisSize.min, // Respects BaseDialog Column
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Academic Transcript", style: AppFonts.headline),
                Text(
                  "OFFICIAL RECORD • ${allGames.length} ENTRIES",
                  style: AppFonts.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
            // Close button inside the content
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(LucideIcons.x, color: AppColors.onSurfaceVariant, size: 20),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(height: 1),
        ),
        
        SizedBox(
          height: 400, 
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allGames.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return HistoryItemCard(game: allGames[index]);
            },
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Footer
        Text(
          "Only the last 50 attempts are retained.",
          style: AppFonts.labelSmall.copyWith(
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}