import 'package:uniordle/shared/exports/home_exports.dart';

class MajorGrid extends StatelessWidget {
  final List<Major> majors;
  final List<String> unlockedIds;
  final void Function(Major) onSubjectTap;

  const MajorGrid({
    super.key,
    required this.majors,
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
      itemCount: majors.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          SizedBox(height: 84, child: _buildTile(majors[index])),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: majors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 84,
      ),
      itemBuilder: (context, index) => _buildTile(majors[index]),
    );
  }

  Widget _buildTile(Major sub) {
    final bool isLocked = !unlockedIds.contains(sub.id);
    return MajorTile(
      major: sub,
      isLocked: isLocked,
      onTap: () => onSubjectTap(sub),
    );
  }
}
