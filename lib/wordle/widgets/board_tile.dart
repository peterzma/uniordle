import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';
import 'package:flutter_wordle/app/app_colors.dart';


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
      duration: const Duration(milliseconds: 12000),
      vsync: this,
    );

    _scale = Tween<double>(
      begin: 1.0,
      end: 5.0,
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
      child: Transform.scale(
        scale: _scale.value,
        child: Container(
          margin: const EdgeInsets.all(4),
          height: 64,
          width: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.letter.val.isEmpty
                ? tileBackground
                : widget.letter.backgroundColor,
            border: Border.all(
              color: widget.letter.backgroundColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: FittedBox(
            child: Text(
              widget.letter.val,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}