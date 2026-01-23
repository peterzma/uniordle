import 'package:uniordle/shared/exports/game_screen_exports.dart';


class DialogHeader extends StatefulWidget {
  final bool won;

  const DialogHeader({super.key, required this.won});
  
  @override
  State<DialogHeader> createState() => _DialogHeaderState();

}

class _DialogHeaderState extends State<DialogHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Pulse animation
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color effectColor = widget.won ? AppColors.correctColor : Colors.red;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: effectColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Icon(
              widget.won ? Icons.stars_rounded : Icons.close_rounded,
              color: widget.won ? AppColors.correctColor : Colors.red,
              size: 64,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          widget.won ? 'YOU WIN!' : 'GAME OVER',
          style: AppTextStyles.displayLarge
        ),
      ],
    );
  }
}