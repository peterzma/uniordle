import 'package:uniordle/shared/exports/profile_screen_exports.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant, 
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(), 
            style: AppTextStyles.labelMedium
          ),
          Text(
            value, 
            style: AppTextStyles.headline
          ),
        ],
      ),
    );
  }
}