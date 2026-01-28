import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDisciplineTap(BuildContext context, Discipline sub, UserStats stats) {
    if (stats.unlockedIds.contains(sub.id)) {
    Navigator.of(context).pushNamed('/setup', arguments: sub);
    return;
    } else if (!stats.hasAnyUnlock) {
      _showUnlockDialog(context, sub, isFree: true);
    } else {
      _showUnlockDialog(context, sub, isFree: false);
    }
  }

  void _showUnlockDialog(BuildContext context, Discipline sub, {required bool isFree}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isFree ? "START YOUR CAREER" : "LOCKED"),
        content: Text(isFree 
          ? "Choose ${sub.name} as your primary discipline? This first choice is free." 
          : "You haven't unlocked ${sub.name} yet. Continue playing to earn Merit and unlock more!"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("BACK")),
          if (isFree) ElevatedButton(
          onPressed: () async {
            await statsManager.unlockDiscipline(sub.id);
            if (context.mounted) {
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${sub.name} is now available!"),
                  backgroundColor: sub.color,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text("UNLOCK"),
        ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        return Padding(
          padding: const EdgeInsets.all(AppLayout.sidePadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const HomeHero(),
                const SizedBox(height: 36),
                DisciplineGrid(
                    disciplines: DisciplinesData.all,
                    unlockedIds: stats.unlockedIds,
                    onSubjectTap: (sub) => _onDisciplineTap(context, sub, stats),
                  ),
              ],
            ),
          ),
        );
      }
    );
  }
}