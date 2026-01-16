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
      case 'category':
        return LucideIcons.layoutGrid;
      default:
        return LucideIcons.bookOpen;
    }
  }
}
