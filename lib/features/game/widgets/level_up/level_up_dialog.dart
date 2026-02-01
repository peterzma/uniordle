import 'package:confetti/confetti.dart';
import 'package:uniordle/features/game/widgets/level_up/milestone_celebration_dialog.dart';
import 'package:uniordle/features/game/widgets/level_up/performance_breakdown.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';

enum MilestoneType { levelUp, creditEarned, rankUp }

class LevelUpDialog extends StatefulWidget {
  final int startingLevel;
  final double startingProgress;
  final double gainedMerit;
  final Major major;
  final int attempts;
  final int maxAttempts;
  final bool won;

  const LevelUpDialog({
    super.key,
    required this.startingLevel,
    required this.startingProgress,
    required this.gainedMerit,
    required this.major,
    required this.attempts,
    required this.maxAttempts,
    required this.won,
  });

  @override
  State<LevelUpDialog> createState() => _LevelUpDialogState();
}

class _LevelUpDialogState extends State<LevelUpDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;
  
  int _lastThrottledLevel = 0;

  @override
  void initState() {
    super.initState();
    _lastThrottledLevel = widget.startingLevel;
    
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));

    final double startTotal = widget.startingLevel + widget.startingProgress;
    final double levelChange = widget.gainedMerit / UserStats.meritPerLevel;
    final double endTotal = startTotal + levelChange;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + (levelChange.abs() * 500).toInt()),
    );

    _animation = Tween<double>(begin: startTotal, end: endTotal)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _controller.addListener(() {
      final int currentLevel = _animation.value.floor();
      
      if (currentLevel > _lastThrottledLevel) {
        _lastThrottledLevel = currentLevel;
        
        _confettiController.play();

        if (currentLevel % 10 == 0) {
          _showMilestoneDialog(MilestoneType.rankUp, currentLevel);
        } else if (currentLevel % 5 == 0) {
          _showMilestoneDialog(MilestoneType.creditEarned, currentLevel);
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
  }

  void _showMilestoneDialog(MilestoneType type, int level) {
    showDialog(
      context: context,
      // Prevents accidental closing during the celebration
      barrierDismissible: false, 
      builder: (context) => MilestoneCelebrationDialog(type: type, level: level),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "STUDIES REPORT",
                style: AppFonts.displayLarge,
              ),
            ),
            SizedBox(height: context.r(32)),
            PerformanceBreakdown(
              won: widget.won,
              attempts: widget.attempts,
              maxAttempts: widget.maxAttempts,
              gainedMerit: widget.gainedMerit,
            ),
            SizedBox(height: context.r(16)),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                final double val = _animation.value;
                final int displayLevel = val.floor();
                final double displayProgress = val % 1.0;
                final int percentage = (displayProgress * 100).round();
                
                return LevelCard(
                  level: displayLevel,
                  progress: displayProgress,
                  nextLevel: displayLevel + 1,
                  progressLabel: "$percentage%",
                );
              },
            ),
            SizedBox(height: context.r(32)), 
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'HOME',
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
                  ),
                ),
                SizedBox(width: context.r(16)),
                Expanded(
                  child: PrimaryButton(
                    label: 'NEW GAME',
                    color: AppColors.accent,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/setup',
                        (route) => route.isFirst,
                        arguments: widget.major,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          numberOfParticles: 20,
          gravity: 0.2,
        ),
      ],
    );
  }
}