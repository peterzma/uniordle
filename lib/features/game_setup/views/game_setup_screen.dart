import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/game_setup/widgets/merit_preview_badge.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
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
    final bool mobileMode = AppLayout.mobileMode(context);
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
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight, 
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GameSetupHero(discipline: widget.discipline),
                          SizedBox(height: mobileMode ? 12 : 48),
                          WordLengthSelector(
                            value: _wordLength, 
                            onChanged: (v) => setState(() => _wordLength = v),
                            discipline: widget.discipline,
                          ),
                          SizedBox(height: mobileMode ? 24 : 48),
                          DifficultySelector(
                            value: _difficulty, 
                            onChanged: (v) => setState(() => _difficulty = v),
                            discipline: widget.discipline,
                          ),
                        ],
                      ),
                    ),
                  );
                  }
                ),
              ),

              const SizedBox(height: 12),

              MeritPreviewBadge(
                difficulty: _difficulty,
                wordLength: _wordLength,
                discipline: widget.discipline,
              ),

              const SizedBox(height: 12),

              PrimaryButton(
                label: 'PLAY GAME',
                onPressed: _play,
                color: widget.discipline.color,
                isLoading: _isLoading,
                icon: AppIcons.play,
                showShadow: true,
                height: 64,
                width: double.infinity,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}