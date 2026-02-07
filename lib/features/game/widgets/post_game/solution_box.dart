import 'package:uniordle/shared/exports/post_game_exports.dart';

class SolutionBox extends StatelessWidget {
  final String solution;

  const SolutionBox({super.key, required this.solution});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'THE WORD WAS',
            style: AppFonts.labelLarge.copyWith(
              color: AppColorsDark.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.r(8)),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.outline, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                solution.toUpperCase(),
                style: AppFonts.displayLarge.copyWith(
                  fontSize: 48,
                  letterSpacing: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
