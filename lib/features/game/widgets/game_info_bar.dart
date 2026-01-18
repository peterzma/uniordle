import 'package:uniordle/shared/exports/game_screen_exports.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 468), 
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: _InfoTag(
                label: disciplineName, 
                color: AppColors.keyBackground,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _InfoTag(
                label: '$wordLength LETTERS', 
                color: AppColors.keyBackground,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _InfoTag(
                label: yearLevel, 
                color: AppColors.keyBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String label;
  final Color color;

  const _InfoTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GameFonts.infoBarText,
      ),
    );
  }
}