import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/features/game_setup/widgets/game_setup_hero.dart';

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

    await Future.delayed(const Duration(milliseconds: 250));

    if (!mounted) return;

    await Navigator.pushNamed(
      context, 
      '/uniordle',
      arguments: {
        'discipline': widget.discipline,
        'wordLength': _wordLength,
        'difficulty': _difficulty,
      },
    );

    if (mounted) {
    setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SettingsHeader(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Column(
            children: [
              GameSetupHero(discipline: widget.discipline),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WordLengthSelector(
                      value: _wordLength, 
                      onChanged: (v) => setState(() => _wordLength = v),
                      discipline: widget.discipline,
                    ),
                    const SizedBox(height: 48),
                    DifficultySelector(
                      value: _difficulty, 
                      onChanged: (v) => setState(() => _difficulty = v),
                      discipline: widget.discipline,
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
              SettingsFooter(
                isLoading: _isLoading, 
                onPlay: _play, 
                onClose: () => Navigator.pop(context),
                discipline: widget.discipline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}