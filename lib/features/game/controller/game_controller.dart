import 'package:uniordle/shared/exports/game_exports.dart';

enum GameStatus { playing, submitting, won, lost }

class GameController extends ChangeNotifier {
  final int wordLength;
  final int maxAttempts;
  final String majorId;
  final int yearLevel;
  final Function(bool won) onGameEnd;
  final VoidCallback? onInvalidWord;

  GameController({
    required this.wordLength,
    required this.maxAttempts,
    required this.yearLevel,
    required this.majorId,
    required this.onGameEnd,
    this.onInvalidWord,
  }) {
    _initGame();
  }

  late List<Word> board;
  late List<List<GlobalKey<FlipCardState>>> flipCardKeys;
  late Word solution;
  int currentWordIndex = 0;
  bool get hasSubmissions => currentWordIndex > 0;
  GameStatus status = GameStatus.playing;
  final Set<Letter> keyboardLetters = {};

  Word? get currentWord => currentWordIndex < board.length ? board[currentWordIndex] : null;

  void _initGame() {
    board = List.generate(maxAttempts, (_) => Word(letters: List.generate(wordLength, (_) => Letter.empty())));
    flipCardKeys = List.generate(maxAttempts, (_) => List.generate(wordLength, (_) => GlobalKey<FlipCardState>()));

    final userSolvedWords = statsManager.statsNotifier.value.solvedWords;
    
    final String nextWord = WordRepository.getNextWord(
      majorId: majorId,
      length: wordLength,
      userSolvedWords: userSolvedWords,
    );

    solution = Word.fromString(nextWord.toUpperCase());
  }

  // Validates correct guess
  Future<void> submitWord() async {
    if (status != GameStatus.playing || currentWord == null) return;
    if (currentWord!.letters.any((l) => l.val.isEmpty)) return;

    final guess = currentWord!.wordString; 
    if (!WordRepository.isValidWord(guess)) {
      onInvalidWord?.call(); 
      return;
    }

    // Lock the game state during the animation sequence
    status = GameStatus.submitting;
    notifyListeners();

    List<String> remainingLetters = solution.letters.map((l) => l.val).toList();
    List<LetterStatus> statuses = List.filled(wordLength, LetterStatus.notInWord);

    // First pass: Find Correct
    for (int i = 0; i < wordLength; i++) {
      if (currentWord!.letters[i].val == solution.letters[i].val) {
        statuses[i] = LetterStatus.correct;
        remainingLetters[i] = "";
      }
    }

    // Second pass: Find Correct but wrong position
    for (int i = 0; i < wordLength; i++) {
      if (statuses[i] != LetterStatus.correct) {
        int indexInRemaining = remainingLetters.indexOf(currentWord!.letters[i].val);
        if (indexInRemaining != -1) {
          statuses[i] = LetterStatus.inWord;
          remainingLetters[indexInRemaining] = "";
        }
      }
    }

    // Flip tiles one by one with sound
    for (int i = 0; i < wordLength; i++) {
      currentWord!.letters[i] = currentWord!.letters[i].copyWith(status: statuses[i]);
      _updateKeyboard(currentWord!.letters[i]);
      
      notifyListeners();

      SoundManager().play(SoundType.tileFlip);

      // Trigger the UI flip animation
      if (currentWordIndex < flipCardKeys.length && i < flipCardKeys[currentWordIndex].length) {
        flipCardKeys[currentWordIndex][i].currentState?.toggleCard();
      }
      
      // Wait for animation to finish before next tile
      await Future.delayed(const Duration(milliseconds: AppLayout.flipSpeedMs));
    }

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
        word: solution.wordString,
        yearLevel: yearLevel, 
        wordLength: wordLength, 
        attempts: currentWordIndex + 1,
        maxAttempts: maxAttempts,
      );
      onGameEnd(true);
    } else if (currentWordIndex + 1 >= maxAttempts) {
      status = GameStatus.lost;
      statsManager.recordLoss(wordLength: wordLength, maxAttempts: maxAttempts, word: solution.wordString);
      onGameEnd(false);
    } else {
      status = GameStatus.playing;
      currentWordIndex++;
    }
    notifyListeners();
  }

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

  void restart() {
    currentWordIndex = 0;
    status = GameStatus.playing;
    keyboardLetters.clear();
    _initGame();
    notifyListeners();
  }

  void abandonGame() {
    if (status == GameStatus.playing || status == GameStatus.submitting) {
      status = GameStatus.lost;
      statsManager.recordAbandonment(
        word: solution.wordString,
        wordLength: wordLength, 
        maxAttempts: maxAttempts
      );
      notifyListeners();
    }
  }
}