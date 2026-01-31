import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/core/app_layout.dart';

class DisciplineGrid extends StatelessWidget {
  final List<Discipline> disciplines;
  final List<String> unlockedIds;
  final void Function(Discipline) onSubjectTap;

  const DisciplineGrid({
    super.key,
    required this.disciplines,
    required this.unlockedIds,
    required this.onSubjectTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool useListMode = AppLayout.mobileMode(context);

    return useListMode ? _buildListView() : _buildGridView();
  }

  Widget _buildListView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: disciplines.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => SizedBox(
        height: 80,
        child: _buildTile(disciplines[index]),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: disciplines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 80,
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