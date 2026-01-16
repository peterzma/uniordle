import 'package:uniordle/shared/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';

class GameSettingsScreen extends StatefulWidget {
  final Discipline discipline;

  const GameSettingsScreen({
    super.key,
    required this.discipline,
  });

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  int _wordLength = 5;
  int _difficulty = 1;
  bool _isLoading = false;

  void _play() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushNamed(
      context, 
      '/uniordle',
      arguments: {
        'discipline': widget.discipline,
        'wordLength': _wordLength,
        'difficulty': _difficulty,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Column(
            children: [
              SettingsHeader(discipline: widget.discipline),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WordLengthSelector(
                      value: _wordLength, 
                      onChanged: (v) => setState(() => _wordLength = v),
                    ),
                    const SizedBox(height: 48),
                    DifficultySelector(
                      value: _difficulty, 
                      onChanged: (v) => setState(() => _difficulty = v),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
              SettingsFooter(
                isLoading: _isLoading, 
                onPlay: _play, 
                onClose: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}