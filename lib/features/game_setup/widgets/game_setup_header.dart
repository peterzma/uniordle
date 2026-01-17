import 'package:uniordle/shared/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';

class SettingsHeader extends StatelessWidget {
  final Discipline discipline;

  const SettingsHeader({
    super.key,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white10),
          ),
          child: Icon(
            _icon(discipline.icon),
            color: discipline.color,
            size: 48,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          discipline.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'GAME SETTINGS',
          style: GameSetUpFonts.gameSettingsText,
        ),
      ],
    );
  }

  IconData _icon(String name) {
    switch (name) {
      case 'category':
        return LucideIcons.layoutGrid;
      default:
        return LucideIcons.bookOpen;
    }
  }
}