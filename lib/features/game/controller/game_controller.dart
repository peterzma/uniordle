import 'package:uniordle/features/game/data/word_repository.dart';
import 'package:uniordle/features/profile/controller/stats_manager.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:math';

enum GameStatus { playing, submitting, won, lost }

class GameController extends ChangeNotifier {
  final int wordLength;
  final int maxAttempts;
  final String disciplineId;
  final int yearLevel;
  final Function(bool won) onGameEnd;
  final VoidCallback? onInvalidWord;

  final Duration _flipDuration = const Duration(milliseconds: 160);

  GameController({
    required this.wordLength,
    required this.maxAttempts,
    required this.yearLevel,
    required this.disciplineId,
    required this.onGameEnd,
    this.onInvalidWord,
  }) {
    _initGame();
  }

  late List<Word> board;
  late List<List<GlobalKey<FlipCardState>>> flipCardKeys;
  late Word solution;
  int currentWordIndex = 0;
  GameStatus status = GameStatus.playing;
  final Set<Letter> keyboardLetters = {};

  void _initGame() {
    board = List.generate(
      maxAttempts, 
      (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty()))
    );
    
    flipCardKeys = List.generate(
      maxAttempts, 
      (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>())
    );
    
    final disciplineLibrary = categorizedWords[disciplineId.toLowerCase()] ?? categorizedWords['engineering']!;
    final library = disciplineLibrary[wordLength] ?? disciplineLibrary[5]!;

    solution = Word.fromString(
      library[Random().nextInt(library.length)].toUpperCase(),
    );
  }

  Word? get currentWord => currentWordIndex < board.length ? board[currentWordIndex] : null;

  void addLetter(String val) {
    if (status == GameStatus.playing) {
      currentWord?.addLetter(val);
      notifyListeners();
    }
  }

  void removeLetter() {
    if (status == GameStatus.playing) {
      currentWord?.removeLetter();
      notifyListeners();
    }
  }

  Future<void> submitWord() async {
    if (status != GameStatus.playing || currentWord == null) return;
    if (currentWord!.letters.any((l) => l.val.isEmpty)) return;

    final guess = currentWord!.wordString; 
    if (!WordRepository.isValidWord(guess)) {
      onInvalidWord?.call(); 
      
      return;
    }

    status = GameStatus.submitting;
    notifyListeners();

    List<String> remainingLetters = solution.letters.map((l) => l.val).toList();
    List<LetterStatus> statuses = List.filled(wordLength, LetterStatus.notInWord);

    for (int i = 0; i < wordLength; i++) {
      if (currentWord!.letters[i].val == solution.letters[i].val) {
        statuses[i] = LetterStatus.correct;
        remainingLetters[i] = "";
      }
    }

    for (int i = 0; i < wordLength; i++) {
      if (statuses[i] != LetterStatus.correct) {
        int indexInRemaining = remainingLetters.indexOf(currentWord!.letters[i].val);
        if (indexInRemaining != -1) {
          statuses[i] = LetterStatus.inWord;
          remainingLetters[indexInRemaining] = "";
        }
      }
    }

    // reveal letters 1 by 1
    for (int i = 0; i < wordLength; i++) {
      currentWord!.letters[i] = currentWord!.letters[i].copyWith(status: statuses[i]);
      _updateKeyboard(currentWord!.letters[i]);
      
      notifyListeners();

      SoundManager().play(SoundType.keyboard);

      notifyListeners();

      if (currentWordIndex < flipCardKeys.length && i < flipCardKeys[currentWordIndex].length) {
        flipCardKeys[currentWordIndex][i].currentState?.toggleCard();
      }
      
      await Future.delayed(_flipDuration);
    }

    await Future.delayed(const Duration(milliseconds: 200));

    _checkResult();
  }

  void _updateKeyboard(Letter newLetter) {
    final existing = keyboardLetters.firstWhere((l) => l.val == newLetter.val, orElse: () => Letter.empty());
    if (existing.status != LetterStatus.correct) {
      keyboardLetters.removeWhere((l) => l.val == newLetter.val);
      keyboardLetters.add(newLetter);
    }
  }

  void _checkResult() {
    if (currentWord!.wordString == solution.wordString) {
      status = GameStatus.won;
      statsManager.recordWin(
        yearLevel: yearLevel, 
        wordLength: wordLength, 
        attempts: currentWordIndex + 1,
      );
      onGameEnd(true);
    } else if (currentWordIndex + 1 >= maxAttempts) {
      status = GameStatus.lost;
      statsManager.recordLoss();
      onGameEnd(false);
    } else {
      status = GameStatus.playing;
      currentWordIndex++;
    }
    notifyListeners();
  }

  void restart() {
    currentWordIndex = 0;
    status = GameStatus.playing;
    keyboardLetters.clear();
    _initGame();
    notifyListeners();
  }
}