import 'package:flutter/material.dart';

class EndGameDialog extends StatelessWidget {
  final bool won;
  final String solution;
  final int attempts;
  final VoidCallback onRestart;

  const EndGameDialog({
    required this.won,
    required this.solution,
    required this.attempts,
    required this.onRestart,
  });

  @override
}