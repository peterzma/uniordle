import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/features/home/widgets/unlock_discipline_dialog.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/layout/base_show_dialog.dart';
import 'package:uniordle/shared/responsive/responsive_layout.dart';

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

        return ResponsiveLayout(
          smallScreen: _buildSmallHome(context, stats, sortedDisciplines),
          largeScreen: _buildLargeHome(context, stats, sortedDisciplines),
        );
      },
    );
  }

  Widget _buildLargeHome(BuildContext context, UserStats stats, List<Discipline> disciplines) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppLayout.sidePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeHero(stats: stats),
          const SizedBox(height: AppLayout.badgeToContent),
          DisciplineGrid(
            isSmall: false,
            disciplines: disciplines,
            unlockedIds: stats.unlockedIds,
            onSubjectTap: (sub) => _onDisciplineTap(context, sub, stats),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallHome(BuildContext context, UserStats stats, List<Discipline> disciplines) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: HomeHero(stats: stats),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: DisciplineGrid(
                  isSmall: true,
                  disciplines: disciplines,
                  unlockedIds: stats.unlockedIds,
                  onSubjectTap: (sub) => _onDisciplineTap(context, sub, stats),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}