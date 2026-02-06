import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/major.dart';

class GameSetupHero extends StatelessWidget {
  final Major major;

  const GameSetupHero({
    super.key,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        final progress = stats.getMajorProgress(major.id, major.totalWords);
        final bool isFullyMastered = progress.percent >= 1.0;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MajorIcon(
              icon: major.icon,
              color: major.color,
              dimension: 80,
              iconSize: 48,
              rounding: 32,
              shadows: isFullyMastered ? [
                Shadow(
                  color: major.color.withValues(alpha: 0.1),
                  blurRadius: 10,
                ),
              ] : null,
            ),
            SizedBox(height: context.r(8)),
            context.autoText(
              major.name,
              style: AppFonts.displayLarge,
            ),
            context.autoText(
              'MAJOR SETTINGS',
              style: AppFonts.labelLarge.copyWith(color: major.color),
            ),
          ],
        );
      }
    );
  }
}