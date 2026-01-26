import 'package:uniordle/shared/exports/home_exports.dart';

class DisciplineGrid extends StatelessWidget {
  final List<Discipline> disciplines;
  final void Function(Discipline) onSubjectTap;

  const DisciplineGrid({super.key, required this.disciplines, required this.onSubjectTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: disciplines.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 12,
          childAspectRatio: 3.5,
        ),
        itemBuilder: (context, index) {
          final sub = disciplines[index];
          return DisciplineTile(discipline: sub, onTap: () => onSubjectTap(sub));
        },
      ),
    );
  }
}
