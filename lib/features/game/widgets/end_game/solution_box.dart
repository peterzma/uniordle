import 'package:uniordle/shared/exports/game_screen_exports.dart';

class SolutionBox extends StatelessWidget {
  final String solution;

  const SolutionBox({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'THE WORD WAS',
          style: AppTextStyles.headline.copyWith(color: AppColors.onSurfaceVariant)
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              solution.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.displayLarge.copyWith(letterSpacing: 4),
            ),
          ),
        ],
      ),
    );
  }
}