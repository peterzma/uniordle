import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/icons/icon_mapper.dart';

class SubjectIcon extends StatelessWidget {
  final String iconName;
  final Color? color;

  const SubjectIcon({
    super.key, 
    required this.iconName, 
    required this.color
  });

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
      child: Icon(IconMapper.getIcon(iconName), color: color, size: 24),
    );
  }
}
