import 'package:uniordle/shared/exports/game_exports.dart';

class BoardTile extends StatefulWidget {
  final Letter letter;
  final Color? initialBorderColor;
  final Duration entranceDelay;

  const BoardTile({
    super.key,
    required this.letter,
    this.initialBorderColor,
    this.entranceDelay = Duration.zero,
  });

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile>
    with SingleTickerProviderStateMixin {
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

    _controller = AnimationController(duration: _typingDuration, vsync: this);

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
    final double tileSize = context.responsive(60, 64);
    final Color backgroundColor = widget.letter.val.isEmpty
        ? context.surfaceVariant
        : context.getLetterBgColor(widget.letter.status);
    // final Color borderColor = context.getLetterBorderColor(widget.letter);
    return ScaleTransition(
      scale: _scale,
      child: Container(
        margin: EdgeInsets.all(context.r(4)),
        height: tileSize,
        width: tileSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          // border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.letter.val,
          textAlign: TextAlign.center,
          style: context.textTheme.displayLarge,
        ),
      ),
    );
  }
}
