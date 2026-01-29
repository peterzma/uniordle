import 'package:uniordle/features/game/widgets/level_up/performance_breakdown.dart';
import 'package:uniordle/features/game/widgets/level_up/milestone_item.dart'; // Ensure this import exists
import 'package:uniordle/shared/exports/end_game_exports.dart';

class LevelUpDialog extends StatefulWidget {
  final int startingLevel;
  final double startingProgress;
  final double gainedMerit;
  final Discipline discipline;
  final int attempts;
  final int maxAttempts;
  final bool won;

  const LevelUpDialog({
    super.key,
    required this.startingLevel,
    required this.startingProgress,
    required this.gainedMerit,
    required this.discipline,
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
  
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _visibleMilestones = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final double startTotal = widget.startingLevel + widget.startingProgress;
    final double levelChange = widget.gainedMerit / UserStats.meritPerLevel;
    final double endTotal = startTotal + levelChange;

    // Adjust duration based on how many levels were gained
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + (levelChange.abs() * 500).toInt()),
    );

    _animation = Tween<double>(begin: startTotal, end: endTotal)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

    _controller.addListener(() {
      final double animatedVal = _animation.value;
      final int animatedLevel = animatedVal.floor();
      
      final List<int> allAchieved = statsManager.statsNotifier.value.achievedMilestones;

      // Trigger milestones as the bar animates past them
      for (int level in allAchieved) {
        if (level <= animatedLevel && 
            level > widget.startingLevel && 
            !_visibleMilestones.contains(level)) {
          
          _revealMilestone(level);
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
  }

  void _revealMilestone(int level) {
    if (!mounted) return;
    setState(() {
      _visibleMilestones.insert(0, level);
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
    });
    
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "ACADEMIC PROGRESS",
          style: AppFonts.displayLarge,
        ),
        const SizedBox(height: 16),
        
        // Performance Reasoner
        PerformanceBreakdown(
          won: widget.won,
          attempts: widget.attempts,
          maxAttempts: widget.maxAttempts,
          gainedMerit: widget.gainedMerit,
        ),
        
        const SizedBox(height: 12),
        
        // Animated Level Progress
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
    
        const SizedBox(height: 16),
      
        // List of unlocked milestones (Rank ups, Credits, etc)
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: AnimatedList(
            key: _listKey,
            controller: _scrollController,
            shrinkWrap: true,
            initialItemCount: _visibleMilestones.length,
            itemBuilder: (context, index, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: MilestoneItem(level: _visibleMilestones[index]),
                  ),
                ),
              );
            },
          ),
        ),
    
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
      ],
    );
  }
}