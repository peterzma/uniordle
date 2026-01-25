import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final double progress; // Value between 0.0 and 1.0
  final int nextLevel;

  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.nextLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant, 
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            "LEVEL $level",
            style: AppTextStyles.displayMedium,
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2), 
              borderRadius: BorderRadius.circular(36),
            ),
            child: Text(
              "${(progress * 100).toInt()}% TO LEVEL $nextLevel",
              style: AppTextStyles.labelSmall
            ),
          ),
        ],
      ),
    );
  }
}