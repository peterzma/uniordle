import 'package:uniordle/shared/exports/home_exports.dart';

class UnlockMajorDialog extends StatefulWidget {
  final Major major;
  final int credits;
  final int nextLevel;

  const UnlockMajorDialog({
    super.key,
    required this.major,
    required this.credits,
    required this.nextLevel,
  });

  @override
  State<UnlockMajorDialog> createState() => _UnlockMajorDialogState();
}

class _UnlockMajorDialogState extends State<UnlockMajorDialog> {
  bool _isUnlocked = false;
  final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

  void _handleUnlock() async {
    await statsManager.unlockMajor(widget.major.id);
    if (mounted) {
      setState(() {
        _isUnlocked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isUnlocked) {
      return UnlockedMajorDialog(major: widget.major);
    }

    final stats = statsManager.statsNotifier.value;
    final bool isFirstEnrollment = stats.unlockedIds.isEmpty;

    final bool canAfford = widget.credits > 0;
    final Color buttonColor = canAfford
        ? widget.major.color
        : AppColorsDark.onSurfaceVariant.withValues(alpha: 0.5);
    final Color statusColor = canAfford
        ? widget.major.color
        : AppColorsDark.onSurfaceVariant.withValues(alpha: 0.5);

    final String bonusText = isFirstEnrollment
        ? "FIRST ENROLLMENT"
        : "PERMANENT +5% MAJOR BONUS";

    final IconData bonusIcon = isFirstEnrollment
        ? AppIcons.firstEnrollment
        : AppIcons.permanentMeritBonus;

    final wiggleKey = GlobalKey<WiggleButtonWrapperState>();

    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.responsive(60, 80),
            height: context.responsive(60, 80),
            decoration: BoxDecoration(
              color: context.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              AppIcons.profileLock,
              color: statusColor,
              size: context.r(60),
            ),
          ),
          SizedBox(height: context.r(8)),

          context.autoText(
            canAfford ? "Enroll in ${widget.major.name}?" : "RESTRICTED",
            style: AppFonts.headlineMedium,
          ),
          SizedBox(height: context.r(16)),

          context.autoText(
            canAfford
                ? "Spend 1 Credit to unlock ${widget.major.name}?"
                : "You don't have any credits to enroll in ${widget.major.name}.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 2,
          ),

          SizedBox(height: context.r(16)),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: canAfford
                  ? widget.major.color.withValues(alpha: 0.1)
                  : AppColorsDark.onSurfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.autoIcon(
                  bonusIcon,
                  size: 16,
                  color: canAfford
                      ? widget.major.color
                      : AppColorsDark.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                context.autoText(
                  bonusText,
                  style: AppFonts.labelSmall.copyWith(
                    color: canAfford
                        ? widget.major.color
                        : AppColorsDark.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.r(16)),

          Column(
            children: [
              if (!canAfford) ...[
                context.autoText(
                  "(Credit available at Level ${widget.nextLevel})",
                  style: AppFonts.labelMedium,
                ),
                SizedBox(height: context.r(16)),
              ],
            ],
          ),

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
                    label: "ENROLL",
                    color: buttonColor,
                    onPressed: () {
                      if (canAfford) {
                        _handleUnlock();

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
