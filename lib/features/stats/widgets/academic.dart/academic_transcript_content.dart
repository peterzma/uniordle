import 'package:uniordle/shared/exports/stats_exports.dart';

class AcademicTranscriptContent extends StatelessWidget {
  final UserStats stats;

  const AcademicTranscriptContent({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final allGames = stats.gameHistory.reversed.toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transcript", style: AppFonts.headlineMedium),
                Text("${allGames.length} ENTRIES", style: AppFonts.labelMedium),
              ],
            ),
            // Close button inside the content
            SimpleButton(
              icon: AppIcons.navClose,
              onTap: () => Navigator.pop(context),
              color: AppColors.onSurfaceVariant,
              iconSize: 16,
            ),
          ],
        ),

        SizedBox(height: context.r(16)),

        SizedBox(
          height: context.responsive(200, 400),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allGames.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return HistoryItemCard(game: allGames[index]);
            },
          ),
        ),

        SizedBox(height: context.r(16)),

        Text("Only the last 50 scores are shown.", style: AppFonts.labelMedium),
      ],
    );
  }
}
