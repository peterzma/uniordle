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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MajorIcon(
          iconName: major.icon,
          color: major.color,
          dimension: 80,
          iconSize: 48,
          rounding: 32,
        ),
        SizedBox(height: context.r(8)),
        context.autoText(
          major.name,
          style: AppFonts.displayLarge,
        ),
        context.autoText(
          'GAME SETTINGS',
          style: AppFonts.labelLarge.copyWith(color: major.color),
        ),
      ],
    );
  }
}