import 'package:uniordle/shared/home_screen_exports.dart';

class DisciplineGrid extends StatelessWidget {
  final List<Discipline> disciplines;
  final void Function(Discipline) onSubjectTap;

  const DisciplineGrid({super.key, required this.disciplines, required this.onSubjectTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: disciplines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        final sub = disciplines[index];
        return SubjectTile(discipline: sub, onTap: () => onSubjectTap(sub));
      },
    );
  }
}
