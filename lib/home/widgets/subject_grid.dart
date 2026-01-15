import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/home/models/subject.dart';

class SubjectGrid extends StatelessWidget {
  final List<Subject> subjects;
  final void Function(Subject) onSubjectTap;

  const SubjectGrid({
    super.key,
    required this.subjects,
    required this.onSubjectTap,
  });

  @override
  Widget build (BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: subjects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        final sub = subjects[index];
        return 
      },
    );
  }
}

class _AnimatedSubjectTile extends StatefulWidget {
  final Subject subject;
  final VoidCallback onTap;

  const _AnimatedSubjectTile({
    required this.subject,
    required this.onTap,
  });

  @override
  State<_AnimatedSubjectTile> createState() => _AnimatedSubjectTileState();
}

class _AniamtedSubjectTileState extends StatefulWidget {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);  
}
  IconData _getIcon(String name) {
    switch (name) {
      case 'category':
        return LucideIcons.layoutGrid;
      default:
        return LucideIcons.bookOpen;
    }
  }