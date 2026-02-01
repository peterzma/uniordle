import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/core/app_icons.dart';

class MajorIcon extends StatelessWidget {
  final String iconName;
  final Color? color;
  final double iconSize;
  final double dimension;
  final double rounding;

  const MajorIcon({
    super.key,
    required this.iconName,
    required this.color,
    this.iconSize = 24,
    this.dimension = 40,
    this.rounding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(rounding),
      ),
      child: Icon(
        IconMapper.getIcon(iconName),
        color: color,
        size: iconSize,
      ),
    );
  }
}