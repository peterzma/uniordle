import 'package:uniordle/shared/exports/game_exports.dart';
import 'dart:ui';

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
late GameController _controller;
  bool _isInitialized = false;

  String _disciplineName = '';
  String _yearLevel = '';
  int _wordLength = 5;
  int _maxAttempts = 6;

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!_isInitialized) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final discipline = args?['discipline'] as Discipline?;
    final dynamic rawDifficulty = args?['yearLevel'] ?? 1; // 1 is default yearLevel
    final int yearLevel = rawDifficulty is double ? rawDifficulty.round() : rawDifficulty as int;
    _wordLength = args?['wordLength'] ?? 5;
    _disciplineName = discipline?.name ?? 'Engineering';

    int attempts;
    switch (yearLevel) {
      case 4: 
        attempts = 5; 
        _yearLevel = 'Postgrad'; 
        break;
      case 3: 
        attempts = 6; 
        _yearLevel = '3rd Year'; 
        break;
      case 2: 
        attempts = 7; 
        _yearLevel = '2nd Year'; 
        break;
      case 1:
      default: 
        attempts = 8; 
        _yearLevel = '1st Year'; 
        break;
    }

    _maxAttempts = attempts;
    
    _controller = GameController(
      wordLength: args?['wordLength'] ?? 5,
      maxAttempts: attempts,
      disciplineId: discipline?.id ?? 'engineering',
      onGameEnd: (won) => _showEndDialog(won),
      onInvalidWord: _showInvalidWord,
      yearLevel: yearLevel,
    );

    _controller.addListener(() => setState(() {}));
    _isInitialized = true;
  }
  }

void _showEndDialog(bool won) {
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  final discipline = args?['discipline'] as Discipline;

  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    builder: (context) {
      return EndDialog(
        won: won,
        solution: _controller.solution.wordString,
        attempts: _controller.currentWordIndex + 1,
        maxAttempts: _maxAttempts,
        discipline: discipline,
        yearLevel: _yearLevel,
        onRestart: () {
          Navigator.pop(context);
          _controller.restart();
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const GameHeader(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppLayout.sidePadding),
                child: Board(
                  board: _controller.board, 
                  flipCardKeys: _controller.flipCardKeys
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Column(
              children: [
                GameInfoBar(
                  disciplineName: _disciplineName,
                  yearLevel: _yearLevel,
                  wordLength: _wordLength,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Keyboard(
                    onKeyTapped: _controller.addLetter,
                    onDeleteTapped: _controller.removeLetter,
                    onEnterTapped: _controller.submitWord,
                    letters: _controller.keyboardLetters,
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }

  void _showInvalidWord() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (dialogContext) {
        final navigator = Navigator.of(dialogContext);

        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted && navigator.canPop()) {
            navigator.pop();
          }
        });

        return BaseDialog(
          blur: 0.0,
          child: Text(
            'Word not found', 
            textAlign: TextAlign.center,
            style: AppFonts.labelLarge
          ),
        );
      },
    );
  }
}