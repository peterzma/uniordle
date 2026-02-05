import 'package:uniordle/core/app_icons.dart';
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              allMajorsUnlocked ? LucideIcons.sparkles : LucideIcons.lock,
              color: accentColor,
              size: context.r(48),
            ),
          ),
          
          SizedBox(height: context.r(16)),
          
          context.autoText(
            "Bonus Research",
            style: AppFonts.headline,
          ),
          
          SizedBox(height: context.r(12)),
          
          context.autoText(
            !allMajorsUnlocked 
              ? "You must unlock all available Majors before beginning Bonus Research."
              : "Apply your extra credit toward permanent academic research to boost your Major Bonus.",
            textAlign: TextAlign.center,
            style: AppFonts.labelMedium,
            maxLines: 3,
          ),

          SizedBox(height: context.r(24)),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: accentColor.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.trendingUp, size: 16, color: accentColor),
                const SizedBox(width: 8),
                context.autoText(
                  "+5% PERMANENT BONUS",
                  style: AppFonts.labelSmall.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: context.r(24)),
          
          if (!allMajorsUnlocked) ...[
            context.autoText(
              "Majors Unlocked: ${stats.unlockedIds.length}/${MajorsData.all.length}",
              style: AppFonts.labelSmall.copyWith(color: AppColors.accent2),
            ),
          ] else if (!canAfford) ...[
             context.autoText(
               "Earn another credit at Level ${widget.nextLevel}",
               style: AppFonts.labelSmall,
             ),
          ],

          SizedBox(height: context.r(24)),

          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Navigator.pop(context),
                  label: "BACK",
                ),
              ),
              SizedBox(width: context.r(12)),
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