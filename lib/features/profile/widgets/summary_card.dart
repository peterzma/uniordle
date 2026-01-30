import 'package:auto_size_text/auto_size_text.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

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
    height: 140,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surfaceVariant, 
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Center(
            child: AutoSizeText(
              label.toUpperCase(),
              style: AppFonts.labelMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 8,
            ),
          ),
        ),
        AutoSizeText(
          value,
          style: AppFonts.headline,
          maxLines: 1,
        ),
      ],
    ),
  );
}
}