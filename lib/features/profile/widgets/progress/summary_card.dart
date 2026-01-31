import 'package:uniordle/shared/exports/game_exports.dart';

class SummaryCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color iconColor;

  const SummaryCard({
    super.key, 
    required this.label, 
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
Widget build(BuildContext context) {
  return Container(
    height: context.responsive(120, 160),
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant, 
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: context.responsive(24, 32)),
        SizedBox(height: 8),
        Center(
          child: context.autoText(
            label.toUpperCase(),
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        context.autoText(
          value,
          style: AppFonts.headline,
        ),
      ],
    ),
  );
}
}