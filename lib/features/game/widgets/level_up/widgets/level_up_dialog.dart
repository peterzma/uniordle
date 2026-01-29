import 'package:uniordle/core/app_icons.dart';
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
  
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _visibleMilestones = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

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
      final double animatedVal = _animation.value;
      final int animatedLevel = animatedVal.floor();
      
      final List<int> allAchieved = statsManager.statsNotifier.value.achievedMilestones;

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
    
    // Auto-scroll to the top to show the newest achievement
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut
      );
    }
    
    // SoundManager().play(SoundType.grid);
  }

  String _getMilestoneTitle(int level) {
    if (level % 10 == 0) return "RANK UP & CREDIT +1";
    if (level % 5 == 0 && level <= 70) return "CREDIT +1";
    return "LEVEL UP!";
  }

  String _getMilestoneSubtitle(int level) {
    if (level % 10 == 0) {
      final String rank = UserStats(
        streak: 0, solved: 0, merit: level * UserStats.meritPerLevel
      ).academicTitle;
      return "Promoted to $rank. Check the Home screen to spend your credit.";
    }
    if (level % 5 == 0) return "Check the Home screen to spend your credit";
    return "You have reached LEVEL $level";
  }

  @override
  void dispose() {
    _controller.dispose();
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
                    child: _buildMilestoneItem(_visibleMilestones[index]),
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
      
      ]
    );
  } 

  Widget _buildMilestoneItem(int level) {
    final bool isRankUp = level % 10 == 0;
    final bool isCreditEarned = level % 5 == 0;
    final bool isCreditOnly = level % 5 == 0 && level % 10 != 0;
    
    final Color bgColor = isRankUp 
      ? AppColors.accent3 
      : (isCreditOnly ? AppColors.accent : AppColors.surfaceVariant);
    
    final Color contentColor = (isRankUp || isCreditEarned) 
        ? AppColors.onSurface 
        : AppColors.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            isRankUp ? LucideIcons.graduationCap : (isCreditOnly ? AppIcons.credits : AppIcons.merits),
            size: 20,
            color: contentColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getMilestoneTitle(level),
                  style: AppFonts.labelLarge.copyWith(
                    color: contentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getMilestoneSubtitle(level),
                  style: AppFonts.labelSmall.copyWith(
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



