import 'package:uniordle/shared/exports/post_game_exports.dart';
import 'package:uniordle/features/profile/widgets/progress/level_card.dart';
import 'package:uniordle/shared/wrappers/celebration_wrapper.dart';

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

class _LevelUpDialogState extends State<LevelUpDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;
  int _lastThrottledLevel = 0;

  @override
  void initState() {
    super.initState();
    _lastThrottledLevel = widget.startingLevel;

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    final double startTotal = widget.startingLevel + widget.startingProgress;
    final double levelChange = widget.gainedMerit / UserStats.meritPerLevel;
    final double endTotal = startTotal + levelChange;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1500 + (levelChange.abs() * 500).toInt(),
      ),
    );

    _animation = Tween<double>(begin: startTotal, end: endTotal).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    )..addListener(_onAnimationTick);

    Future.delayed(
      const Duration(milliseconds: 400),
      () => _controller.forward(),
    );
  }

  void _onAnimationTick() {
    final int currentLevel = _animation.value.floor();

    if (currentLevel > _lastThrottledLevel) {
      _lastThrottledLevel = currentLevel;
      _triggerMilestoneEffects(currentLevel);
    }
  }

  void _triggerMilestoneEffects(int level) {
    _confettiController.play();
    if (level % 10 == 0) {
      SoundManager().play(SoundType.rankUp);
      _showMilestone(MilestoneType.rankUp, level);
    } else if (level % 5 == 0) {
      SoundManager().play(SoundType.creditEarned);
      _showMilestone(MilestoneType.creditEarned, level);
    } else {
      SoundManager().play(SoundType.levelUp);
    }
  }

  void _showMilestone(MilestoneType type, int level) {
    showDialog(
      context: context,
      builder: (context) =>
          MilestoneCelebrationDialog(type: type, level: level),
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
    return CelebrationWrapper(
      externalController: _confettiController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.autoText(
            "STUDIES REPORT",
            style: context.textTheme.displayLarge,
          ),
          SizedBox(height: context.r(32)),

          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              final double val = _animation.value;
              final int displayLevel = val.floor();
              final double progress = val % 1.0;

              return LevelCard(
                level: displayLevel,
                progress: progress,
                nextLevel: displayLevel + 1,
                progressLabel: "${(progress * 100).round()}%",
              );
            },
          ),

          SizedBox(height: context.r(8)),
          PerformanceBreakdown(
            won: widget.won,
            attempts: widget.attempts,
            maxAttempts: widget.maxAttempts,
            gainedMerit: widget.gainedMerit,
          ),

          SizedBox(height: context.r(32)),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            label: 'HOME',
            onPressed: () => Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (_) => false),
          ),
        ),
        SizedBox(width: context.r(16)),
        Expanded(
          child: PrimaryButton(
            label: 'NEW GAME',
            color: context.colorScheme.primary,
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/setup',
              (route) => route.isFirst,
              arguments: widget.major,
            ),
          ),
        ),
      ],
    );
  }
}
