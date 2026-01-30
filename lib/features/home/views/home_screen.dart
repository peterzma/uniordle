import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/features/home/widgets/unlock_discipline_dialog.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/layout/base_show_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDisciplineTap(BuildContext context, Discipline sub, UserStats stats) {
    if (stats.unlockedIds.contains(sub.id)) {
      Navigator.of(context).pushNamed('/setup', arguments: sub);
    } else {
      baseShowDialog(
        context: context,
        child: UnlockDisciplineDialog(
          discipline: sub,
          credits: stats.availableCredits,
          nextLevel: stats.nextCreditAtLevel,
        ),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return ValueListenableBuilder(
    valueListenable: statsManager.statsNotifier,
    builder: (context, stats, _) {
      final sortedDisciplines = DisciplinesData.getSortedDisciplines(stats.unlockedIds);

      return Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppLayout.sidePadding),
            child: Column(
              children: [
                HomeHero(stats: stats),
                const SizedBox(height: AppLayout.badgeToContent),

                DisciplineGrid(
                  disciplines: sortedDisciplines,
                  unlockedIds: stats.unlockedIds,
                  onSubjectTap: (sub) => _onDisciplineTap(context, sub, stats),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      );
    },
  );
}
}