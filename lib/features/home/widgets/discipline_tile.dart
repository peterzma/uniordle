import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class DisciplineTile extends StatefulWidget {
  final Discipline discipline;
  final VoidCallback onTap;
  final bool isLocked;

  const DisciplineTile({
    super.key, 
    required this.discipline, 
    required this.onTap,
    required this.isLocked,
  });

  @override
  State<DisciplineTile> createState() => _DisciplineTileState();
}

class _DisciplineTileState extends State<DisciplineTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final sub = widget.discipline;

    final displayColor = widget.isLocked ? AppColors.onSurfaceVariant.withValues(alpha: 0.5) : sub.color;

    return SelectButtonWrapper(
      onTap: widget.onTap,
      soundType: SoundType.grid,
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _hovering = true);
          SoundManager().play(SoundType.hover);
        },
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering ? displayColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Opacity(
            opacity: widget.isLocked ? 0.5 : 1.0,
            child: Row(
              children: [
                DisciplineIcon(
                  iconName: widget.isLocked ? 'lock' : sub.icon, 
                  color: widget.isLocked ? Colors.grey : sub.color,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sub.name,
                        style: AppFonts.labelLarge,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: displayColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.isLocked ? "LOCKED" : sub.tag, 
                            style: AppFonts.labelSmall.copyWith(color: displayColor)
                          ),
                        ],
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
}