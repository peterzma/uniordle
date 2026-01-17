import 'package:uniordle/shared/home_screen_exports.dart';
import 'package:uniordle/shared/widgets/pump_button_wrapper.dart';

class SubjectTile extends StatefulWidget {
  final Discipline discipline;
  final VoidCallback onTap;

  const SubjectTile({super.key, required this.discipline, required this.onTap});

  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final sub = widget.discipline;

    return PumpButtonWrapper(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F2B),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering ? Colors.blueAccent : Colors.grey.withValues(alpha: 0.4),
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
                    if (sub.tag != null)
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: sub.tag == 'DONE' ? Colors.green : Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            sub.tag!,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: sub.tag == 'DONE' ? Colors.green : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    if (sub.count != null)
                      Text(
                        '${sub.count}',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
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