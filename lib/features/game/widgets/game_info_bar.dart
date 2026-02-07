import 'package:uniordle/shared/exports/game_exports.dart';

class GameInfoBar extends StatelessWidget {
  final String majorName;
  final String yearLevel;
  final int wordLength;

  const GameInfoBar({
    super.key,
    required this.majorName,
    required this.yearLevel,
    required this.wordLength,
  });

  String get _attemptsLabel {
    return DifficultyConfig.getAttemptsByLabel(yearLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: InfoTag(label: majorName)),
            SizedBox(width: context.r(8)),
            Expanded(child: InfoTag(label: '$wordLength LETTERS')),
            SizedBox(width: context.r(8)),
            Expanded(
              child: InfoTag(
                label: _attemptsLabel,
                icon: context.autoIcon(
                  AppIcons.gameAttempts,
                  size: 14,
                  color: context.colorScheme.onSurfaceVariant,
                  reduction: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
