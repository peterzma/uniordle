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
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'THE WORD WAS',
          style: AppFonts.labelLarge.copyWith(color: AppColors.onSurfaceVariant)
          ),
          SizedBox(height: context.r(8)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: AppColors.outline,
                width: 2
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                solution.toUpperCase(),
                style: AppFonts.displayLarge.copyWith(fontSize: 48, letterSpacing: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}