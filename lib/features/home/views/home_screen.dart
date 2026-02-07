import 'package:uniordle/shared/exports/home_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onMajorTap(BuildContext context, Major sub, UserStats stats) {
    if (stats.unlockedIds.contains(sub.id)) {
      Navigator.of(context).pushNamed('/setup', arguments: sub);
    } else {
      showBaseDialog(
        context: context,
        child: UnlockMajorDialog(
          major: sub,
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
        final sortedMajors = MajorsData.getSortedMajors(stats.unlockedIds);

        return Scaffold(
          backgroundColor: context.surface,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppLayout.pagePadding),
              child: Column(
                children: [
                  HomeHero(stats: stats),

                  SizedBox(height: context.r(16)),

                  MajorGrid(
                    majors: sortedMajors,
                    unlockedIds: stats.unlockedIds,
                    onSubjectTap: (sub) => _onMajorTap(context, sub, stats),
                  ),

                  if (stats.masteredCount >= MajorsData.all.length) ...[
                    SizedBox(height: context.r(32)),
                    PulsingButtonWrapper(
                      glowColor: AppColorsDark.accent3,
                      child: PrimaryButton(
                        label: "The Oracle's Legacy",
                        color: AppColorsDark.accent3,
                        onPressed: () {
                          showBaseDialog(
                            context: context,
                            child: const Ascension(),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
