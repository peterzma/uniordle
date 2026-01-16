import 'package:flip_card/flip_card.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/uniordle/uniordle.dart';
import 'package:uniordle/uniordle/views/end_dialog.dart';
import 'dart:math';

const Duration _tileFlipDuration = Duration(milliseconds: 100);
const double _bottomKeyboardPadding = 20;
const double _topTitlePadding = 128;
const double _titleFontSize = 72;

enum GameStatus { 
  playing,
  submitting,
  won,
  lost
}

class UniordleScreen extends StatefulWidget {
  const UniordleScreen({
    super.key,
    });

  @override
  _UniordleScreenState createState() => _UniordleScreenState();
}

class _UniordleScreenState extends State<UniordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  late int _wordLength;
  late int _maxAttempts;
  late List<Word> _board;
  late List<List<GlobalKey<FlipCardState>>> _flipCardKeys;
  late Word _solution;
  
  final Set<Letter> _keyboardLetters = {};
  int _currentWordIndex = 0;
  bool _isInitialised = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // load arguments only once when the screen loads
    if (!_isInitialised) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      // Fallback values if arguments are missing
      _wordLength = args?['wordLength'] ?? 5;
      _maxAttempts = 6; 

      _initGameState();
      _isInitialised = true;
    }
  }

  /// Sets up or resets the game board and solution
  void _initGameState() {
    _board = List.generate(
      _maxAttempts,
      (_) => Word(letters: List.generate(_wordLength, (_) => Letter.empty())),
    );
    
    _flipCardKeys = List.generate(
      _maxAttempts,
      (_) => List.generate(_wordLength, (_) => GlobalKey<FlipCardState>()),
    );

    List<String> library;
    switch (_wordLength) {
      case 4: library = fiveLetterWords; break;
      case 6: library = fiveLetterWords; break;
      case 5:
      default:
        library = fiveLetterWords;
    }

    _solution = Word.fromString(
      library[Random().nextInt(library.length)].toUpperCase(),
    );
  }

  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  @override
  Widget build(BuildContext context) {

    if (!_isInitialised) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.gameBackground,
      appBar: const UniordleAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Board(board: _board, flipCardKeys: _flipCardKeys),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: _bottomKeyboardPadding),
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
      await Future.delayed(_tileFlipDuration * 0.7);
    }

    await Future.delayed(_tileFlipDuration * 0.3);
      
    _checkIfWinOrLoss();
  }

  void _checkIfWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;
      _showEndDialog(
        won: true,
      );
    } else if (_currentWordIndex + 1 >= _board.length) {
      _gameStatus = GameStatus.lost;
      _showEndDialog(
        won: false
      );
    } else {
      _gameStatus = GameStatus.playing;
      _currentWordIndex += 1;
    }
  }

  void _showEndDialog({
    required bool won,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => EndGameDialog(
        won: won,
        solution: _solution.wordString,
        attempts: _currentWordIndex + 1,
        onRestart: () {
          Navigator.of(context).pop();
          _restart();
        }
      ),
    );
  }

  void _restart() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _keyboardLetters.clear();
      _initGameState();
    });
  }
}