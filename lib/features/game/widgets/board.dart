import 'package:flip_card/flip_card.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

const int _flipSpeed = 600;

/// Displays the Uniordle game board
/// 
/// Renders each guessed [World] as a row of tiles and
/// controls flip animations using [FlipCard]
class Board extends StatelessWidget {
  const Board({ 
    super.key,
    required this.board,
    required this.flipCardKeys,
  });

  /// List of words for the current board state
  final List<Word> board;

  /// Keys to control flip animations for each tile
  final List<List<GlobalKey<FlipCardState>>> flipCardKeys;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: board.asMap().entries.map((rowEntry) {
          final i = rowEntry.key;
          final word = rowEntry.value;

          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: word.letters.asMap().entries.map((letterEntry) {
              final j = letterEntry.key;
              final letter = letterEntry.value;

                return FlipCard(
                  key: flipCardKeys[i][j],
                  flipOnTouch: false,
                  direction: FlipDirection.VERTICAL,
                  speed: _flipSpeed,
                  front: BoardTile(
                    letter: Letter(
                      val: letter.val,
                      status: LetterStatus.initial,
                    ),
                  ),
                  back: BoardTile(letter: letter),
                );
              }).toList(),
            );
        }).toList(),
      ),
    );
  }
}