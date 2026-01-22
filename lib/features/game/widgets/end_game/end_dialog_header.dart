import 'package:uniordle/shared/exports/game_screen_exports.dart';


class DialogHeader extends StatelessWidget {
  final bool won;

  const DialogHeader({super.key, required this.won});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF1B2E1D),
            shape: BoxShape.circle,
          ),
          child: Icon(
            won ? Icons.stars_rounded : Icons.close_rounded,
            color: won ? Color(0xFF55B725) : Colors.red,
            size: 64,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          won ? 'YOU WIN!' : 'GAME OVER',
          style: AppTextStyles.displayLarge
        ),
      ],
    );
  }
}