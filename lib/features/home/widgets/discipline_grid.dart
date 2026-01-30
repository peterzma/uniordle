import 'package:uniordle/shared/exports/home_exports.dart';

class DisciplineGrid extends StatelessWidget {
  final List<Discipline> disciplines;
  final List<String> unlockedIds;
  final void Function(Discipline) onSubjectTap;
  final int crossAxisCount;

  const DisciplineGrid({
    super.key, 
    required this.disciplines, 
    required this.unlockedIds,
    required this.onSubjectTap,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: disciplines.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 1 ? 6.0 : 3.1,
        ),
        itemBuilder: (context, index) {
          final sub = disciplines[index];
          final bool isLocked = !unlockedIds.contains(sub.id);
          
          return DisciplineTile(
            discipline: sub, 
            isLocked: isLocked,
            onTap: () => onSubjectTap(sub),
          );
        },
      ),
    );
  }
}
