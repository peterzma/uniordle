import 'package:uniordle/features/game/widgets/end_game/end_dialog.dart';
import 'package:uniordle/features/game/widgets/game_info_bar.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';

class UniordleScreen extends StatefulWidget {
  const UniordleScreen({
    super.key,
    });

  @override
  _UniordleScreenState createState() => _UniordleScreenState();
}

class _UniordleScreenState extends State<UniordleScreen> {
late UniordleController _controller;
  bool _isInitialized = false;

  String _disciplineName = '';
  String _yearLevel = '';
  int _wordLength = 5;

@override
void didChangeDependencies() {
  super.didChangeDependencies();

  if (!_isInitialized) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final discipline = args?['discipline'] as Discipline?;
    final dynamic rawDifficulty = args?['difficulty'] ?? 1; // 1 is default difficulty
    final int difficulty = rawDifficulty is double ? rawDifficulty.round() : rawDifficulty as int;
    _wordLength = args?['wordLength'] ?? 5;
    _disciplineName = discipline?.name ?? 'Engineering';

    int attempts;
    switch (difficulty) {
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
    
    _controller = UniordleController(
      wordLength: args?['wordLength'] ?? 5,
      maxAttempts: attempts,
      disciplineId: discipline?.id ?? 'engineering',
      onGameEnd: (won) => _showEndDialog(won),
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
      barrierDismissible: false,
      builder: (context) => EndGameDialog(
        won: won,
        solution: _controller.solution.wordString,
        attempts: _controller.currentWordIndex + 1,
        discipline: discipline,
        onRestart: () {
          Navigator.pop(context);
          _controller.restart();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: const GameHeader(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
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
}