import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';
import 'package:flutter_wordle/app/app_colors.dart';

const double _boardTileFontSize = 32;
const double _boardTileSize = 64;
const double _boardTileGapPadding = 4;
const double _boardTileCornerRounding = 5;
const double _boardBorderWidth = 2;
const Duration _pumpDuration = Duration(milliseconds: 80);
const double _pumpBeginScale = 1.0;
const double _pumpEndScale = 1.05;

class BoardTile extends StatefulWidget {
  const BoardTile({
    Key? key,
    required this.letter,
    this.initialBorderColor = tileBackground, 
  }) : super (key: key);

  final Letter letter;
  final Color initialBorderColor;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
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
    // 0.0 for beginning of animation
    if (oldWidget.letter.val != widget.letter.val) _controller.forward(from: 0.0);
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
        margin: const EdgeInsets.all(_boardTileGapPadding),
        height: _boardTileSize,
        width: _boardTileSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.letter.val.isEmpty
              ? tileBackground
              : widget.letter.backgroundColor,
          border: Border.all(
            color: widget.letter.backgroundColor,
            width: _boardBorderWidth,
          ),
          borderRadius: BorderRadius.circular(_boardTileCornerRounding),
        ),
        child: Text(
          widget.letter.val,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: _boardTileFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}