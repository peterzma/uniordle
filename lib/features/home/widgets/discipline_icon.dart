import 'package:uniordle/shared/home_screen_exports.dart';

class SubjectIcon extends StatelessWidget {
  final String iconName;
  final Color? color;

  const SubjectIcon({super.key, required this.iconName, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_getIcon(iconName), color: color ?? Colors.blue, size: 24),
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
