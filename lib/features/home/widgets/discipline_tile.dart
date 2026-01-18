import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class DisciplineTile extends StatefulWidget {
  final Discipline discipline;
  final VoidCallback onTap;

  const DisciplineTile({super.key, required this.discipline, required this.onTap});

  @override
  State<DisciplineTile> createState() => _DisciplineTileState();
}

class _DisciplineTileState extends State<DisciplineTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final sub = widget.discipline;

    return PumpButtonWrapper(
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
            color: AppColors.tileBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering ? sub.color : AppColors.disciplineTile.withValues(alpha: 0.4),
              width: _hovering ? 1.5 : 0.5,
            ),
          ),
          child: Row(
            children: [
              SubjectIcon(iconName: sub.icon, color: sub.color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sub.name,
                      style: HomeFonts.disciplineText,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sub.color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          sub.tag,
                          style: HomeFonts.tagText(sub.color),
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
    );
  }
}