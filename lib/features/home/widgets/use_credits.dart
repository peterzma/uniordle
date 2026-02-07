import 'package:uniordle/shared/exports/home_exports.dart';

class UseCredits extends StatefulWidget {
  final int credits;
  final int nextLevel;

  const UseCredits({super.key, required this.credits, required this.nextLevel});

  @override
  State<UseCredits> createState() => _UseCreditsState();
}

class _UseCreditsState extends State<UseCredits> {
  final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

  void _handleBonusBoost() async {
    await statsManager.applyMajorBonusBoost();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final stats = statsManager.statsNotifier.value;

    final bool unlockedAllMajors =
        stats.unlockedIds.length >= MajorsData.all.length;
    final bool canAfford = widget.credits > 0;
    final bool canApply = unlockedAllMajors && canAfford;

    final Color accentColor = canApply
        ? context.colorScheme.secondary
        : context.colorScheme.onSurfaceVariant;

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.responsive(60, 80),
            height: context.responsive(60, 80),
            decoration: BoxDecoration(
              color: context.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              unlockedAllMajors ? AppIcons.badgeResearch : AppIcons.profileLock,
              color: accentColor,
              size: context.r(60),
            ),
          ),

          SizedBox(height: context.r(8)),

          context.autoText(
            !unlockedAllMajors ? "???" : "Extra Research",
            style: context.headlineMedium,
          ),

          SizedBox(height: context.r(16)),

          context.autoText(
            !unlockedAllMajors
                ? "You must enroll in all available Majors before proceeding."
                : "Apply your extra credit towards completing more research.",
            textAlign: TextAlign.center,
            style: context.labelMedium,
            maxLines: 2,
          ),

          SizedBox(height: context.r(16)),

          if (unlockedAllMajors) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  context.autoIcon(
                    AppIcons.permanentMeritBonus,
                    size: 16,
                    color: accentColor,
                  ),
                  const SizedBox(width: 8),
                  context.autoText(
                    "PERMANENT +10% MAJOR BONUS",
                    style: context.labelSmall.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.r(16)),
          ],

          if (!unlockedAllMajors) ...[
            context.autoText(
              "Enrolled Majors: ${stats.unlockedIds.length}/${MajorsData.all.length}",
              style: context.labelMedium,
            ),
            SizedBox(height: context.r(16)),
          ] else if (!canAfford) ...[
            context.autoText(
              "(Credit available at Level ${widget.nextLevel})",
              style: context.labelMedium,
            ),
            SizedBox(height: context.r(16)),
          ],

          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Navigator.pop(context),
                  label: "BACK",
                ),
              ),
              SizedBox(width: context.r(16)),
              Expanded(
                child: WiggleButtonWrapper(
                  key: wiggleKey,
                  child: PrimaryButton(
                    label: "APPLY",
                    color: canApply
                        ? context.colorScheme.secondary
                        : context.colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                    onPressed: () {
                      if (canApply) {
                        _handleBonusBoost();
                        SoundManager().play(SoundType.unlockMajor);
                      } else {
                        wiggleKey.currentState?.wiggle();
                        SoundManager().play(SoundType.lockedMajor);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
