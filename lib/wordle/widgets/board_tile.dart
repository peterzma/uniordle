import 'package:flutter/material.dart';
import 'package:flutter_wordle/wordle/wordle.dart';

class BoardTile extends StatefulWidget {
  const BoardTile({
    Key? key,
    required this.letter,
    this.initialBorderColor = const Color(0xFF3A3A3C), 
  }) : super (key: key);

  final Letter letter;
  final Color initialBorderColor;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // pump effect
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant BoardTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // plays pump effect when added letter
    if (oldWidget.letter.val.isEmpty && widget.letter.val.isNotEmpty) {
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
    return Container(
      margin: const EdgeInsets.all(3),
      height: 62,
      width: 62,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: letter.backgroundColor,
        border: Border.all(
          color: letter.val.isEmpty ? initialBorderColor : letter.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.zero,
      ),
      // display letter values
      child: Align(
        child: Text(
          letter.val,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}