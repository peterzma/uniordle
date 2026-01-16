import 'package:flutter/material.dart';

class StartGameButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartGameButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Start Game'),
      ),
    );
  }
}