import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

const int _flipSpeed = 600;

class Board extends StatelessWidget {
  const Board({ 
    Key? key, 
    required this.board,
    required this.flipCardKeys,
  }) : super(key: key);

  final List<Word> board;

  final List<List<GlobalKey<FlipCardState>>> flipCardKeys;

@override
Widget build(BuildContext context) {
  return Padding(
    // distance between title and board
    padding: const EdgeInsets.only(top: 20),
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