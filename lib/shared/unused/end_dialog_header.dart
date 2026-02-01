import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';


class EndDialogHeader extends StatelessWidget {
  final bool won;

  const EndDialogHeader({super.key, required this.won});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // background icon circle
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: won
                ? AppColors.correctColor.withValues(alpha: 0.1)
                : Colors.red.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          
          child: Icon(
            won ? AppIcons.gameWin : AppIcons.gameLoss,
            color: won ? AppColors.correctColor : Colors.red,
            size: 64,
          ),
        ),
        Text(
          won ? 'YOU WIN!' : 'GAME OVER',
          style: AppFonts.displayLarge
        ),
      ],
    );
  }
}