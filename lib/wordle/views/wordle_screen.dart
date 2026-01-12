import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app_colors.dart';
import 'package:flutter_wordle/wordle/data/word_list.dart';
import 'package:flutter_wordle/wordle/wordle.dart';
import 'dart:math';

const Duration _flipDuration = Duration(milliseconds: 100);
final int wordLength = 5;
final int maxAttempts = 1;

enum GameStatus { playing, submitting, won, lost }

class WordleScreen extends StatefulWidget {
  const WordleScreen({Key? key}) : super(key: key);

  @override
  _WordleScreenState createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<Word> _board = List.generate(
    maxAttempts,
    (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())),
  );
  
  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    maxAttempts,
    (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()),
  );

  int _currentWordIndex = 0;

  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );

  final Set<Letter> _keyboardLetters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gameBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Uniordle',
            style: TextStyle(
              fontSize: 48,
              fontFamily: 'clashdisplay',
              fontWeight: FontWeight.w400,
              letterSpacing: 4,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Board(board: _board, flipCardKeys: _flipCardKeys),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Keyboard(
              onKeyTapped: _onKeyTapped,
              onDeleteTapped: _onDeleteTapped,
              onEnterTapped: _onEnterTapped,
              letters: _keyboardLetters,
            ),
          ),
        ],
      ),
    );
  }

  void _onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.addLetter(val));
    }
  }

    void _onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() => _currentWord?.removeLetter());
    }
  }

  Future<void> _onEnterTapped() async {
    if (_gameStatus != GameStatus.playing || _currentWord == null) return;
    if (_currentWord!.letters.contains(Letter.empty())) return;
    _gameStatus = GameStatus.submitting;

    // flip all letters with delay
    for (var i = 0; i < _currentWord!.letters.length; i++) {
      final currentWordLetter = _currentWord!.letters[i];
      final currentSolutionLetter = _solution.letters[i];

      setState(() {
        if (currentWordLetter == currentSolutionLetter) {
          _currentWord!.letters[i] =
              currentWordLetter.copyWith(status: LetterStatus.correct);
        } else if (_solution.letters.contains(currentWordLetter)) {
          _currentWord!.letters[i] =
              currentWordLetter.copyWith(status: LetterStatus.inWord);
        } else {
          _currentWord!.letters[i] =  
              currentWordLetter.copyWith(status: LetterStatus.notInWord);
        }
      });

      final letter = _keyboardLetters.firstWhere(
        (e) => e.val == currentWordLetter.val,
        orElse: () => Letter.empty(),
      );
      if (letter.status != LetterStatus.correct) {
        _keyboardLetters.removeWhere((e) => e.val == currentWordLetter.val);
        _keyboardLetters.add(_currentWord!.letters[i]);
      }

      // trigger flip
      _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard();

      // flips slightly overlap
      await Future.delayed(_flipDuration * 0.7);
    }

    await Future.delayed(_flipDuration * 0.3);
      
    _checkIfWinOrLoss();
  }

  void _checkIfWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      _showEndDialog(
        title: 'YOU WON',
        message: 'NUMBER OF ATTEMPTS: ${_currentWordIndex + 1}',
      );
    } else if (_currentWordIndex + 1 >= _board.length) {
      _gameStatus = GameStatus.lost;
      _showEndDialog(
        title: 'YOU LOST',
        message: 'CORRECT WORD: ${_solution.wordString}',
      );
    } else {
      _gameStatus = GameStatus.playing;
      _currentWordIndex += 1;
    }
  }

  void _showEndDialog({
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 400
            child: Column(
              mainAxisAlignment: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'dm-sans',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 24),
                // inner box for solution word
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    border: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'The word was',
                        style: TextStyle(
                          fontSize: 18
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message.split(': ').last // solution word
                          style: const TextStyle(
                            fontSize: 36,
                              fontFamily: 'dm-sans',
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity // button fills box width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _restart();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'NEW GAME',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'dm-sans',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _board
        ..clear()
        ..addAll(
          List.generate(
            maxAttempts,
            (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())),
          ),
        );
      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );
      _flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
            maxAttempts,
            (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()),
          ),
        );
      _keyboardLetters.clear();
    });
  }
}