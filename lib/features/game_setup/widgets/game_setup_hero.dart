import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/core/app_icons.dart';

class GameSetupHero extends StatelessWidget {
  final Discipline discipline;

  const GameSetupHero({
    super.key,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(
            IconMapper.getIcon(discipline.icon),
            color: discipline.color,
            size: 48,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          discipline.name,
          style: AppFonts.displayLarge,
        ),
        Text(
          'GAME SETTINGS',
          style: AppFonts.labelLarge.copyWith(color: discipline.color),
        ),
      ],
    );
  }
}