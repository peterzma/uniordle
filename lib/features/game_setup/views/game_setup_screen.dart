import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/game_setup/widgets/credit_preview_badge.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/features/game_setup/widgets/game_setup_hero.dart';

class GameSetupScreen extends StatefulWidget {
  final Discipline discipline;

  const GameSetupScreen({
    super.key,
    required this.discipline,
  });

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
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
        'yearLevel': _difficulty,
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
      appBar: const GameSetupHeader(),
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
                    const Spacer(flex: 2),
                    DifficultySelector(
                      value: _difficulty, 
                      onChanged: (v) => setState(() => _difficulty = v),
                      discipline: widget.discipline,
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),

              CreditPreviewBadge(
                difficulty: _difficulty,
                wordLength: _wordLength,
                discipline: widget.discipline,
              ),

              const SizedBox(height: 24),

              PrimaryButton(
                label: 'PLAY GAME',
                onPressed: _play,
                color: widget.discipline.color,
                isLoading: _isLoading,
                icon: AppIcons.play,
                showShadow: true,
                borderRadius: 20,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}