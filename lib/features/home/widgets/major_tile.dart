import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class MajorTile extends StatefulWidget {
  final Major major;
  final VoidCallback onTap;
  final bool isLocked;

  const MajorTile({
    super.key, 
    required this.major, 
    required this.onTap,
    required this.isLocked,
  });

  @override
  State<MajorTile> createState() => _MajorTileState();
}

class _MajorTileState extends State<MajorTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final sub = widget.major;
    final displayColor = widget.isLocked ? AppColors.onSurfaceVariant.withValues(alpha: 0.5) : sub.color;

    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        final progressData = stats.getMajorProgress(sub.id, sub.totalWords);
        final bool isFullyMastered = progressData.percent >= 1.0;

        return SelectButtonWrapper(
          onTap: widget.onTap,
          soundType: SoundType.click,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _hovering = true);
              SoundManager().play(SoundType.hover);
            },
            onExit: (_) => setState(() => _hovering = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hovering 
                      ? displayColor 
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: isFullyMastered ? [
                  BoxShadow(
                    color: displayColor.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ] : null,
              ),
              child: Opacity(
                opacity: widget.isLocked ? 0.5 : 1.0,
                child: Row(
                  children: [
                    MajorIcon(
                      icon: widget.isLocked 
                          ? AppIcons.profileLock
                          : sub.icon, 
                      color: widget.isLocked 
                          ? Colors.grey 
                          : displayColor,
                      shadows: isFullyMastered ? [
                        Shadow(
                          color: displayColor,
                          blurRadius: 10.0,
                        ),
                      ] : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sub.name, 
                                style: AppFonts.labelLarge.copyWith(color: AppColors.onSurface)
                              ),
                              if (!widget.isLocked)
                                Text(
                                  "${progressData.solved}/${sub.totalWords}",
                                  style: AppFonts.labelSmall.copyWith(
                                    color: displayColor, 
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Mastery Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                              value: progressData.percent,
                              minHeight: 4,
                              backgroundColor: displayColor.withValues(alpha: 0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(displayColor),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.isLocked 
                                ? "LOCKED" 
                                : (isFullyMastered 
                                    ? "MASTERED" 
                                    : "MASTERY: ${(progressData.percent * 100).toInt()}%"), 
                            style: AppFonts.labelSmall.copyWith(
                              color: displayColor,
                              fontSize: 10,
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}