import 'package:uniordle/shared/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';

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
            border: Border.all(color: AppColors.backgroundBorder),
          ),
          child: Icon(
            _getIcon(discipline.icon),
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

  IconData _getIcon(String name) {
  switch (name) {
    case 'settings':
      return LucideIcons.settings;
    case 'code':
      return LucideIcons.code;
    case 'heart_pulse':
      return LucideIcons.heartPulse;
    case 'scale':
      return LucideIcons.scale;
    case 'brain':
      return LucideIcons.brain;
    case 'palette':
      return LucideIcons.palette;
    case 'briefcase':
      return LucideIcons.briefcase;
    case 'book_open':
      return LucideIcons.bookOpen;
    case 'graduation_cap':
      return LucideIcons.graduationCap;
    case 'calculator':
      return LucideIcons.calculator;
    case 'music':
      return LucideIcons.music;
    case 'flask_conical':
      return LucideIcons.flaskConical;
    case 'pen_tool':
      return LucideIcons.penTool;
    case 'building_2':
      return LucideIcons.building2;
    default:
      return LucideIcons.bookOpen;
    }
  }
}