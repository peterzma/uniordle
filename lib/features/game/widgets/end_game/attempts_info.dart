import 'package:uniordle/shared/exports/game_screen_exports.dart';

class AttemptsInfo extends StatelessWidget {
  final int attempts;
  final int maxAttempts;

  const AttemptsInfo({super.key, required this.attempts, required this.maxAttempts});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 20),
        children: [
          TextSpan(text: '$attempts/$maxAttempts ',
          style: AppTextStyles.displayMedium.copyWith(color: AppColors.correctColor)
          ),
          TextSpan(text: 'Attempts', 
          style: AppTextStyles.displayMedium
          ),
        ],
      ),
    );
  }
}