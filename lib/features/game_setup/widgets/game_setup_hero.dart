import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/icons/icon_mapper.dart';

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
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        Text(
          discipline.name,
          style: GameSetUpFonts.disciplineText,
        ),
        const SizedBox(height: 8),
        Text(
          'GAME SETTINGS',
          style: GameSetUpFonts.gameSettingsText(discipline.color),
        ),
      ],
    );
  }
}