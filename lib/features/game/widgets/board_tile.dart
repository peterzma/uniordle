import 'package:uniordle/shared/exports/game_exports.dart';

class BoardTile extends StatefulWidget {
  const BoardTile({
    super.key,
    required this.letter,
    this.initialBorderColor = AppColors.surfaceVariant,
    this.entranceDelay = Duration.zero,
  });

  final Letter letter;
  final Color initialBorderColor;
  final Duration entranceDelay;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _scale;

  static const Duration _typingDuration = Duration(milliseconds: 80);
  static const Duration _entranceDuration = Duration(milliseconds: 160);


  @override
  void initState() {
    super.initState();

    Future.delayed(widget.entranceDelay, () {
      if (mounted) {
        _controller.forward(from: 0.0);
      }
    });

    _controller = AnimationController(
      duration: _typingDuration,
      vsync: this,
    );

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
    });

    _triggerEntrancePulse();
  }

  void _triggerEntrancePulse() {
    _controller.duration = _entranceDuration;
    _controller.forward(from: 0.0).then((_) {
      _controller.duration = _typingDuration;
    });
  }

  @override
  void didUpdateWidget(covariant BoardTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letter.val != widget.letter.val) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 64,
        width: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.letter.val.isEmpty
              ? AppColors.surfaceVariant
              : widget.letter.backgroundColor,
          border: Border.all(
            color: widget.letter.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.letter.val,
          textAlign: TextAlign.center,
          style: AppFonts.displayLarge,
        ),
      ),
    );
  }
}