import 'package:uniordle/shared/exports/profile_exports.dart';

class RankPathway extends StatelessWidget {
  final int currentLevel;
  const RankPathway({super.key, required this.currentLevel});

  @override
  Widget build(BuildContext context) {
    final int currentRankIndex = allRanks.lastIndexWhere(
      (r) => currentLevel >= r['minLevel'],
    );

    final bool isPathwayComplete = currentRankIndex == allRanks.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppLayout.cardPadding),
          decoration: BoxDecoration(
            color: AppColorsDark.surfaceVariant,
            borderRadius: BorderRadius.circular(AppLayout.cardRounding),
          ),
          child: Column(
            children: List.generate(allRanks.length, (index) {
              final rank = allRanks[index];
              final bool isLast = index == allRanks.length - 1;
              final bool isAchieved = index <= currentRankIndex;
              final bool isNext = index == currentRankIndex + 1;

              // Hide middle "undiscovered" ranks
              if (!isAchieved && !isNext && !isLast) {
                return const SizedBox.shrink();
              }
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
                    context: context,
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
                              ? context.colorScheme.tertiary
                              : (isAchieved
                                    ? AppColorsDark.accent
                                    : AppColorsDark.onSurface),
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
          SizedBox(height: context.r(32)),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: AppLayout.contentWidth(context),
              ),
              child: PulsingButtonWrapper(
                glowColor: context.colorScheme.tertiary,
                child: PrimaryButton(
                  label: 'A Vision from the Beyond',
                  color: context.colorScheme.tertiary,
                  onPressed: () {
                    showBaseDialog(
                      context: context,
                      child: const Commencement(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRankItem({
    required BuildContext context,
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
        ? context.colorScheme.tertiary
        : (isAchieved
              ? AppColorsDark.accent
              : (isNext ? Colors.white : AppColorsDark.onSurfaceVariant));

    return Row(
      children: [
        Icon(
          isLast && isAchieved
              ? AppIcons.badgeOracle
              : (isAchieved
                    ? AppIcons.profileUnlock
                    : (isNext ? AppIcons.profileNext : AppIcons.profileLock)),
          color: rowColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: AppFonts.labelMedium.copyWith(
              color: rowColor,
              fontWeight: isAchieved || isNext
                  ? FontWeight.bold
                  : FontWeight.normal,
              letterSpacing: isSecret ? 2 : null,
            ),
          ),
        ),
        Text(levelRange, style: AppFonts.labelSmall.copyWith(color: rowColor)),
      ],
    );
  }
}

final List<Map<String, dynamic>> allRanks = [
  {'title': 'UNDERGRADUATE', 'minLevel': 0},
  {'title': 'BACHELOR', 'minLevel': 10},
  {'title': 'MASTER', 'minLevel': 20},
  {'title': 'DOCTORATE', 'minLevel': 30},
  {'title': 'PROFESSOR', 'minLevel': 40},
  {'title': 'FELLOW', 'minLevel': 50},
  {'title': 'DEAN', 'minLevel': 60},
  {'title': 'PROVOST', 'minLevel': 70},
  {'title': 'RECTOR', 'minLevel': 80},
  {'title': 'CHANCELLOR', 'minLevel': 90},
  {'title': 'THE ORACLE', 'minLevel': 100},
];
