import 'package:uniordle/shared/exports/game_setup_exports.dart';

class GameSetupHero extends StatelessWidget {
  final Major major;

  const GameSetupHero({super.key, required this.major});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        final progress = stats.getMajorProgress(major.id, major.totalWords);
        final bool isMasteredMajor = progress.percent >= 1.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MajorIcon(
              icon: major.icon,
              color: context.getMajorColor(major.id),
              dimension: 80,
              iconSize: 48,
              rounding: 32,
              shadows: isMasteredMajor
                  ? [
                      Shadow(
                        color: context.getMajorColor(major.id),
                        blurRadius: 20,
                      ),
                    ]
                  : null,
            ),
            SizedBox(height: context.r(8)),
            context.autoText(major.name, style: context.textTheme.displayLarge),
            context.autoText(
              'MAJOR SETTINGS',
              style: context.labelLarge.copyWith(
                color: context.getMajorColor(major.id),
              ),
            ),
          ],
        );
      },
    );
  }
}
