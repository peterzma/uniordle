import 'package:uniordle/shared/exports/core_exports.dart';

class AttemptsInfo extends StatelessWidget {
  final int attempts;
  final int maxAttempts;
  final bool won;

  const AttemptsInfo({
    super.key,
    required this.attempts,
    required this.maxAttempts,
    required this.won,
  });

  @override
  Widget build(BuildContext context) {
    final Color attemptsColor = won ? context.gameColors.correct! : Colors.red;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$attempts/$maxAttempts ',
            style: context.displayMedium.copyWith(color: attemptsColor),
          ),
          TextSpan(text: 'Attempts', style: context.displayMedium),
        ],
      ),
    );
  }
}
