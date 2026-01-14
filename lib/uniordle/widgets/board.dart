import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:uniordle/uniordle/uniordle.dart';

const int _flipSpeed = 600;
const double _titleToBoardPadding = 20;

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
  return Padding(
    padding: const EdgeInsets.only(top: _titleToBoardPadding),
    child: Column(
      children: board
          .asMap()
          .map(
            (i, word) => MapEntry(
              i,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: word.letters
                    .asMap()
                    .map(
                      (j, letter) => MapEntry(
                        j,
                        FlipCard(
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
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          )
          .values
          .toList(),
      ),
    );
  }
}