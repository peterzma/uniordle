import 'package:uniordle/features/home/data/major_data.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/buttons/wiggle_button_wrapper.dart';

class UseCredits extends StatefulWidget {
  final int credits;
  final int nextLevel;

  const UseCredits({
    super.key,
    required this.credits,
    required this.nextLevel,
  });

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
    
    final bool allMajorsUnlocked = stats.unlockedIds.length >= MajorsData.all.length;
    final bool canAfford = widget.credits > 0;
    
    final bool canApply = allMajorsUnlocked && canAfford;

    final Color accentColor = allMajorsUnlocked 
        ? (canAfford ? AppColors.accent3 : AppColors.onSurfaceVariant) 
        : AppColors.onSurfaceVariant;

    return SizedBox(
      width: AppLayout.maxDialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.responsive(60, 80),
            height: context.responsive(60, 80),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              allMajorsUnlocked ? LucideIcons.microscope : Icons.lock_outline,
              color: accentColor,
              size: context.r(60),
            ),
          ),
          
          SizedBox(height: context.r(8)),
          
          context.autoText(
            !allMajorsUnlocked 
              ? "???"
              : "Bonus Research",
            style: AppFonts.headline,
          ),
          
          SizedBox(height: context.r(16)),
          
          context.autoText(
            !allMajorsUnlocked 
              ? "You must enroll in all available Majors before proceeding."
              : "Apply your extra credit toward academic research.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 2,
          ),

          SizedBox(height: context.r(16)),
          
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
                  LucideIcons.trendingUp, 
                  size: 16, 
                  color: accentColor
                ),
                const SizedBox(width: 8),
                context.autoText(
                  "PERMANENT +10% MAJOR BONUS",
                  style: AppFonts.labelSmall.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: context.r(16)),
          
          if (!allMajorsUnlocked) ...[
            context.autoText(
              "Enrolled Majors: ${stats.unlockedIds.length}/${MajorsData.all.length}",
              style: AppFonts.labelMedium,
            ),
            SizedBox(height: context.r(16)),
          ] else if (!canAfford) ...[
             context.autoText(
               "(Credit available at Level ${widget.nextLevel})",
               style: AppFonts.labelMedium,
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
                        ? AppColors.accent3 
                        : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
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