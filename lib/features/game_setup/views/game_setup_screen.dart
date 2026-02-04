import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/features/game_setup/widgets/merit_preview_badge.dart';
import 'package:uniordle/shared/buttons/primary_button.dart';

import 'package:uniordle/features/game_setup/widgets/game_setup_hero.dart';

class GameSetupScreen extends StatefulWidget {
  final Major major;

  const GameSetupScreen({
    super.key,
    required this.major,
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
        'major': widget.major,
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
          padding: const EdgeInsets.all(AppLayout.pagePadding),
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          // SpaceBetween pushes children to the edges of the minHeight
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: context.v(0, 16)),
                              child: GameSetupHero(major: widget.major),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: context.v(16, 32)),
                                context.autoText(
                                  'WORD LENGTH',
                                  style: AppFonts.displayMedium,
                                ),
                                SizedBox(height: context.r(8)),
                                WordLengthSelector(
                                  value: _wordLength,
                                  onChanged: (v) => setState(() => _wordLength = v),
                                  major: widget.major,
                                ),
                                
                                SizedBox(height: context.v(16, 64)),

                                context.autoText(
                                  'YEAR LEVEL',
                                  style: AppFonts.displayMedium,
                                ),
                                DifficultySelector(
                                  value: _difficulty,
                                  onChanged: (v) => setState(() => _difficulty = v),
                                  major: widget.major,
                                ),
                              ],
                            ),

                            // Bottom Buffer: Prevents selectors from hitting the badge
                            SizedBox(height: context.v(16, 64)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
              MeritPreviewBadge(
                difficulty: _difficulty,
                wordLength: _wordLength,
                major: widget.major,
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'PLAY GAME',
                onPressed: _play,
                color: widget.major.color,
                isLoading: _isLoading,
                icon: AppIcons.play,
                height: 64,
                width: double.infinity,
                resizeLabel: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}