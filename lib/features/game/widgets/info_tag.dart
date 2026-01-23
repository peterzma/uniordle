import 'package:uniordle/shared/exports/game_screen_exports.dart';

class InfoTag extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color backgroundColor;

  const InfoTag({
    super.key, 
    required this.label, 
    this.borderColor = AppColors.outline, 
    this.backgroundColor = AppColors.surfaceVariant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.labelMedium,
      ),
    );
  }
}