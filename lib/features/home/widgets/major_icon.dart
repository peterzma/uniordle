import 'package:uniordle/shared/exports/home_exports.dart';

class MajorIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double iconSize;
  final double dimension;
  final double rounding;
  final List<Shadow>? shadows;

  const MajorIcon({
    super.key,
    required this.icon,
    required this.color,
    this.iconSize = 24,
    this.dimension = 40,
    this.rounding = 16,
    this.shadows,
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
        icon,
        color: color,
        size: iconSize,
        shadows: shadows,
      ),
    );
  }
}