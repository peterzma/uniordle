import 'package:uniordle/shared/exports/game_exports.dart';

class AttemptsInfo extends StatelessWidget {
  final int attempts;
  final int maxAttempts;
  final bool won;

  const AttemptsInfo({
    super.key, 
    required this.attempts, 
    required this.maxAttempts,
    required this.won
  });

  @override
  Widget build(BuildContext context) {
    final Color attemptsColor =
        won ? AppColors.correctColor : Colors.red;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$attempts/$maxAttempts ',
          style: AppFonts.displayMedium.copyWith(color: attemptsColor)
          ),
          TextSpan(text: 'Attempts', 
          style: AppFonts.displayMedium
          ),
        ],
      ),
    );
  }
}