import 'package:flutter/material.dart';
import 'package:uniordle/home/models/subject.dart';
import 'discipline_icon.dart';

class SubjectTile extends StatefulWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectTile({super.key, required this.subject, required this.onTap});

  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  double _scale = 1.0;
  bool _hovering = false;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final sub = widget.subject;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
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
                      Text(sub.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
                            Text(sub.tag!, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: sub.tag == 'DONE' ? Colors.green : Colors.blue)),
                          ],
                        ),
                      if (sub.count != null)
                        Text('${sub.count}', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
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
