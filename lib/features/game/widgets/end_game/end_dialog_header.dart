import 'package:uniordle/shared/exports/game_screen_exports.dart';


class DialogHeader extends StatelessWidget {
  final bool won;

  const DialogHeader({super.key, required this.won});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // background icon circle
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: won
                ? AppColors.correctColor.withValues(alpha: 0.15)
                : Colors.red.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          
          child: Icon(
            won ? Icons.stars_rounded : Icons.close_rounded,
            color: won ? AppColors.correctColor : Colors.red,
            size: 64,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          won ? 'YOU WIN!' : 'GAME OVER',
          style: AppFonts.displayLarge
        ),
      ],
    );
  }
}