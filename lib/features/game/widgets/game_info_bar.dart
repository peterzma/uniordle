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
      child: IntrinsicWidth(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 468), 
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: InfoTag(label: disciplineName)),
              const SizedBox(width: 4),
              Expanded(child: InfoTag(label: '$wordLength LETTERS')),
              const SizedBox(width: 4),
              Expanded(child: InfoTag(label: yearLevel)),
            ],
          ),
        )
      ),
    );
  }
}