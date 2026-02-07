import 'package:uniordle/shared/exports/game_setup_exports.dart';

class GameSetupScreen extends StatefulWidget {
  final Major major;

  const GameSetupScreen({super.key, required this.major});

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
      backgroundColor: context.surface,
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
                                  style: context.displayMedium,
                                ),
                                SizedBox(height: context.r(8)),
                                WordLengthSelector(
                                  value: _wordLength,
                                  onChanged: (v) =>
                                      setState(() => _wordLength = v),
                                  major: widget.major,
                                ),

                                SizedBox(height: context.v(16, 64)),

                                context.autoText(
                                  'YEAR LEVEL',
                                  style: context.displayMedium,
                                ),
                                DifficultySelector(
                                  value: _difficulty,
                                  onChanged: (v) =>
                                      setState(() => _difficulty = v),
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

              const SizedBox(height: 8),
              MeritPreviewBadge(
                difficulty: _difficulty,
                wordLength: _wordLength,
                major: widget.major,
              ),
              SizedBox(height: context.v(8, 16)),
              PrimaryButton(
                label: 'PLAY GAME',
                onPressed: _play,
                color: context.getMajorColor(widget.major.id),
                isLoading: _isLoading,
                icon: AppIcons.gamePlay,
                resizeLabel: false,
              ),
              SizedBox(height: context.v(16, 32)),
            ],
          ),
        ),
      ),
    );
  }
}
