import 'package:uniordle/shared/exports/post_game_exports.dart';

class PostGameDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final int maxAttempts;
  final String yearLevel;
  final Major major;
  final int gainedMerit;

  const PostGameDialog({
    super.key,
    required this.won,
    required this.solution,
    required this.attempts,
    required this.maxAttempts,
    required this.yearLevel,
    required this.major,
    required this.gainedMerit,
  });

  void _handleNext(BuildContext context) {
    final currentStats = statsManager.statsNotifier.value;

    final double directedMerit = won
        ? gainedMerit.toDouble()
        : -gainedMerit.toDouble();

    final prevState = UserStatsProgress.getPreviousState(
      currentStats.merit,
      directedMerit.toInt(),
    );

    Navigator.pop(context);
    showBaseDialog(
      context: context,
      child: LevelUpDialog(
        startingLevel: prevState.$1,
        startingProgress: prevState.$2,
        gainedMerit: directedMerit,
        major: major,
        attempts: attempts,
        maxAttempts: maxAttempts,
        won: won,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(context.r(16)),
            decoration: BoxDecoration(
              color:
                  (won
                          ? context.gameColors.correct
                          : context.colorScheme.error)!
                      .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              won ? AppIcons.gameWin : AppIcons.gameLoss,
              color: won
                  ? context.gameColors.correct
                  : context.colorScheme.error,
              size: context.r(64),
            ),
          ),
          context.autoText(
            won ? 'YOU WIN!' : 'GAME OVER',
            style: context.textTheme.displayLarge,
            reduction: 4,
          ),
          SizedBox(height: context.r(32)),
          SolutionBox(solution: solution),
          SizedBox(height: context.r(16)),
          GameInfoBar(
            majorName: major.name,
            yearLevel: yearLevel,
            wordLength: solution.length,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'NEXT',
            color: context.colorScheme.primary,
            onPressed: () => _handleNext(context),
          ),
        ],
      ),
    );
  }
}
