import 'package:uniordle/shared/exports/game_screen_exports.dart';

/// A single tile displayed on the Uniordle board
/// 
/// Shows a letter, background colour based on [LetterStatus],
/// and plays a brief pump animation when a letter changes
class BoardTile extends StatefulWidget {
  const BoardTile({
    super.key,
    required this.letter,
    this.initialBorderColor = AppColors.tileBackground,
  });

  final Letter letter;
  final Color initialBorderColor;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> with SingleTickerProviderStateMixin{
  /// Controls the pump animation
  late AnimationController _controller;

  static const Duration _pumpDuration = Duration(milliseconds: 80);
  static const double _pumpBeginScale = 1.0;
  static const double _pumpEndScale = 1.05;

  /// Scale animation applied to the tile
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: _pumpDuration,
      vsync: this,
    );

    _scale = Tween<double>(
      begin: _pumpBeginScale,
      end: _pumpEndScale,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
    });
  }

  @override
  void didUpdateWidget(covariant BoardTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    /// Triggers the pump animation when the letter changes
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
              ? AppColors.tileBackground
              : widget.letter.backgroundColor,
          border: Border.all(
            color: widget.letter.backgroundColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.letter.val,
          textAlign: TextAlign.center,
          style: GameFonts.tileText,
        ),
      ),
    );
  }
}