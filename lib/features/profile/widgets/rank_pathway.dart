import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

class RankPathway extends StatelessWidget {
  final int currentLevel;
  const RankPathway({super.key, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    // /// code to test all achieved
    // bool debugComplete = false;

    // int currentRankIndex = debugComplete 
    //   ? allRanks.length - 1 
    //   : allRanks.lastIndexWhere((r) => currentLevel >= r['minLevel']);

    // final bool isPathwayComplete = currentRankIndex == allRanks.length - 1;

    final int currentRankIndex = allRanks.lastIndexWhere(
      (r) => currentLevel >= r['minLevel'],
    );

    final bool isPathwayComplete = currentRankIndex == allRanks.length - 1;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Academic Pathway", style: AppFonts.labelLarge),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: List.generate(allRanks.length, (index) {
              final rank = allRanks[index];
              final bool isLast = index == allRanks.length - 1;
              final bool isAchieved = index <= currentRankIndex;
              final bool isNext = index == currentRankIndex + 1;
              
              // Hide middle "undiscovered" ranks
              if (!isAchieved && !isNext && !isLast) return const SizedBox.shrink();

              // Logic: Only show the title if achieved. 
              // Otherwise, it's a secret (???).
              final String title = isAchieved ? rank['title'] : "???";
              
              // Logic: Only show the level requirement if it's achieved or the immediate next goal.
              final String levelRange = (isAchieved || isNext) 
                  ? "LEVEL ${rank['minLevel']}+" 
                  : "LEVEL ???";

              return Column(
                children: [
                  _buildRankItem(
                    title: title,
                    levelRange: levelRange,
                    isAchieved: isAchieved,
                    isNext: isNext,
                    isLast: isLast,
                    isSecret: !isAchieved,
                    isPathwayComplete: isPathwayComplete,
                  ),
                  if (!isLast && (isAchieved || isNext))
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 11),
                        height: 20,
                        width: 2,
                        decoration: BoxDecoration(
                          color: isPathwayComplete
                              ? Colors.orange
                              : (isAchieved 
                                  ? AppColors.accent 
                                  : AppColors.onSurface),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),

        if (isPathwayComplete) ...[
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'A Message from the Faculty',
            color: Colors.orange, 
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ThankYouDialog(),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildRankItem({
    required String title,
    required String levelRange,
    required bool isAchieved,
    required bool isNext,
    required bool isLast,
    required bool isSecret,
    required bool isPathwayComplete,
  }) {
    // COLOR LOGIC:
    // 1. If everything is done -> All Green
    // 2. If rank is achieved -> Blue (Standard Accent)
    // 3. If rank is next -> White
    // 4. Otherwise -> Grey (Outline)

    final Color rowColor = isPathwayComplete
        ? Colors.orange
        : (isAchieved 
            ? AppColors.accent 
            : (isNext ? Colors.white : AppColors.onSurfaceVariant));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isLast && isAchieved
                ? AppIcons.finalRank
                : (isAchieved ? AppIcons.unlockedRank : (isNext ? AppIcons.nextRank : AppIcons.lockedRank)),
            color: rowColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppFonts.labelMedium.copyWith(
                color: rowColor,
                fontWeight: isAchieved || isNext ? FontWeight.bold : FontWeight.normal,
                letterSpacing: isSecret ? 2 : null,
              ),
            ),
          ),
          Text(
            levelRange,
            style: AppFonts.labelSmall.copyWith(
              color: rowColor,
            ),
          ),
        ],
      ),
    );
  }
}