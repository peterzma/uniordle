import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final double progress; 
  final int nextLevel;
  final String progressLabel;

  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.nextLevel,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5), 
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LevelInfo(label: "CURRENT", level: "Level $level"),
              _LevelInfo(label: "NEXT", level: "Level $nextLevel", crossAlign: CrossAxisAlignment.end),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // The Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // "X/Y SOLVES TO LEVEL Z" Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: Text(
              progressLabel,
              style: AppFonts.labelSmall.copyWith(color: AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelInfo extends StatelessWidget {
  final String label, level;
  final CrossAxisAlignment crossAlign;
  const _LevelInfo({required this.label, required this.level, this.crossAlign = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        Text(label, style: AppFonts.labelSmall.copyWith(color: Colors.grey)),
        Text(level, style: AppFonts.headline.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}