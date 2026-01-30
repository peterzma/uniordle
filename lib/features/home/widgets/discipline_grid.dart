import 'package:uniordle/shared/exports/home_exports.dart';

class DisciplineGrid extends StatelessWidget {
  final List<Discipline> disciplines;
  final List<String> unlockedIds;
  final void Function(Discipline) onSubjectTap;
  final bool isSmall;

  const DisciplineGrid({
    super.key,
    required this.disciplines,
    required this.unlockedIds,
    required this.onSubjectTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return isSmall ? _buildListView() : _buildGridView();
  }

  Widget _buildListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: disciplines.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildTile(disciplines[index]),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: disciplines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) => _buildTile(disciplines[index]),
    );
  }

  Widget _buildTile(Discipline sub) {
    final bool isLocked = !unlockedIds.contains(sub.id);
    return DisciplineTile(
      discipline: sub,
      isLocked: isLocked,
      onTap: () => onSubjectTap(sub),
    );
  }
}