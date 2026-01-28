import 'package:uniordle/features/game/widgets/invalid_word_dialog.dart';
import 'package:uniordle/shared/services/models/difficulty_config.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

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

    final dynamic rawDifficulty = args?['yearLevel'] ?? 1;
    final int yearLevel = rawDifficulty is double ? rawDifficulty.round() : rawDifficulty as int;

    final config = DifficultyConfig.getByLevel(yearLevel);
    _yearLevel = config.$1;
    _maxAttempts = config.$2;

    _wordLength = args?['wordLength'] ?? 5;
    _disciplineName = discipline?.name ?? 'Engineering';
    
    _controller = GameController(
      wordLength: _wordLength,
      maxAttempts: _maxAttempts,
      disciplineId: discipline?.id ?? 'engineering',
      onGameEnd: (won) => _showEndDialog(won),
      onInvalidWord: () => InvalidWordDialog.show(context),
      yearLevel: yearLevel,
    );

    _controller.addListener(() => setState(() {}));
    _isInitialized = true;
    }
  }

  void _showEndDialog(bool won) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final discipline = args?['discipline'] as Discipline;
    final int rawYearLevel = args?['yearLevel'] ?? 1;

    int earnedMerit = 0;

    if (won) {
      earnedMerit = await statsManager.recordWin(
        yearLevel: rawYearLevel,
        wordLength: _controller.solution.wordString.length,
        attempts: _controller.currentWordIndex + 1,
      );
    } else {
      await statsManager.recordLoss();
    }

    if (!mounted) return;

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
          gainedMerit: earnedMerit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
      if (didPop) return;
      
      if (_controller.status == GameStatus.playing || _controller.status == GameStatus.submitting) {
        _controller.abandonGame();
      }
      
      Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: GameHeader(
          onBack: () {
            _controller.abandonGame();
            Navigator.of(context).pop();
          },
        ),
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
      ),
    );
  }
}