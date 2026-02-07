import 'package:uniordle/shared/exports/core_exports.dart';

class PostGameDialogHeader extends StatelessWidget {
  final bool won;

  const PostGameDialogHeader({super.key, required this.won});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // background icon circle
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: won
                ? context.gameColors.correct!.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),

          child: Icon(
            won ? AppIcons.gameWin : AppIcons.gameLoss,
            color: won ? context.gameColors.correct : Colors.red,
            size: 64,
          ),
        ),
        Text(
          won ? 'YOU WIN!' : 'GAME OVER',
          style: context.textTheme.displayLarge,
        ),
      ],
    );
  }
}
