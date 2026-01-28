import 'package:uniordle/shared/exports/end_game_exports.dart';

class LevelUpDialog extends StatefulWidget {
  final int startingLevel;
  final double startingProgress;
  final double gainedMerit;
  final Discipline discipline;

  const LevelUpDialog({
    super.key,
    required this.startingLevel,
    required this.startingProgress,
    required this.gainedMerit,
    required this.discipline,
  });

  @override
  State<LevelUpDialog> createState() => _LevelUpDialogState();
}

class _LevelUpDialogState extends State<LevelUpDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasLeveledUp = false;
  int _newLevelReached = 0;

  @override
  void initState() {
    super.initState();

    const int meritPerLevel = UserStats.meritPerLevel;

    final double startTotal = widget.startingLevel + widget.startingProgress;
    final double levelChange = widget.gainedMerit / meritPerLevel;
    final double endTotal = startTotal + levelChange;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + (levelChange.abs() * 500).toInt()),
    );

    _animation = Tween<double>(begin: startTotal, end: endTotal)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _controller.addListener(() {
      double currentTotal = _animation.value;
      int currentLevel = currentTotal.floor();
      
      if (currentLevel > widget.startingLevel) {
        if (!_hasLeveledUp || _newLevelReached != currentLevel) {
          setState(() {
            _hasLeveledUp = true;
            _newLevelReached = currentLevel;
          });
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
  }

  String _getRankMessage(int level) {
    if (level % 10 == 0) return "NEW ACADEMIC RANK!";
    if (level % 5 == 0 && level <= 70) return "ACADEMIC MILESTONE!";
    return "LEVEL UP!";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: change progress to something else
              // Text("PROGRESS", style: AppFonts.labelMedium),
              // const SizedBox(height: 16),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  final double val = _animation.value;
                  final int displayLevel = val.floor();
                  final double displayProgress = val % 1.0;
                  
                  const int totalRequired = UserStats.meritPerLevel;
                  final int currentLevelMerit = (displayProgress * totalRequired).round();
                  
                  return LevelCard(
                    level: displayLevel,
                    progress: displayProgress,
                    nextLevel: displayLevel + 1,
                    progressLabel: "$currentLevelMerit/$totalRequired",
                  );
                },
              ),
              if (_hasLeveledUp) ...[
                const SizedBox(height: 20),
                _buildMilestoneBox(),
              ],

              const SizedBox(height: AppLayout.gapToButton),

              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'HOME',
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/',
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppLayout.gapBetweenButtons),
                  Expanded(
                    child: PrimaryButton(
                      label: 'NEW GAME',
                      color: AppColors.accent,
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/setup',
                          (route) => route.isFirst,
                          arguments: widget.discipline,
                        );
                      },
                    ),
                  ),
                ],
              ),

            ]
          )
        )
      ) 
    );
  } 

  Widget _buildMilestoneBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Column(
        children: [
          Text(_getRankMessage(_newLevelReached),
              style: AppFonts.labelLarge),
          Text("Level $_newLevelReached attained", style: AppFonts.labelMedium),
        ],
      ),
    );
  }
}



