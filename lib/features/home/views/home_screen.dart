import 'package:uniordle/features/home/data/major_data.dart';
import 'package:uniordle/features/home/widgets/completed_game.dart';
import 'package:uniordle/features/home/widgets/unlock_major_dialog.dart';
import 'package:uniordle/shared/buttons/pulsing_button_wrapper.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';
import 'package:uniordle/shared/layout/show_base_dialog.dart';

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
        backgroundColor: AppColors.surface,
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
                    glowColor: Colors.orange,
                    child: PrimaryButton(
                      label: "The Oracle's Legacy",
                      color: Colors.orange,
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