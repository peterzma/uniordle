import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/services/models/difficulty_config.dart';

class GameInfoBar extends StatelessWidget {
  final String disciplineName;
  final String yearLevel;
  final int wordLength;

  const GameInfoBar({
    super.key,
    required this.disciplineName,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: InfoTag(label: disciplineName)),
              const SizedBox(width: 8),
              Expanded(child: InfoTag(label: '$wordLength LETTERS')),
              const SizedBox(width: 8),
              Expanded(
                child: InfoTag(
                  label: _attemptsLabel, 
                  icon: const Icon(AppIcons.attempts, size: 12, color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}