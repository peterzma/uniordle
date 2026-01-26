import 'package:uniordle/shared/exports/game_exports.dart';

class SolutionBox extends StatelessWidget {
  final String solution;
  final Color backgroundColor;

  const SolutionBox({
    super.key, 
    required this.solution,
    this.backgroundColor = AppColors.surface
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'THE WORD WAS',
          style: AppFonts.labelLarge.copyWith(color: AppColors.onSurfaceVariant)
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 48),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: AppColors.outline,
                width: 2
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              solution.toUpperCase(),
              style: AppFonts.displayLarge.copyWith(fontSize: 48, letterSpacing: 8),
            ),
          ),
        ],
      ),
    );
  }
}