import 'package:flutter/material.dart';

class SettingsFooter extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPlay;
  final VoidCallback onClose;

  const SettingsFooter({
    super.key,
    required this.isLoading,
    required this.onPlay,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : onPlay,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF0A0E17),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
          ),
          child: isLoading
            ? CircularProgressIndicator()
            : const Text(
              'PLAY GAME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            )
        ),
        TextButton(
          onPressed: onClose,  
          child: const Text(
            'Close',
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}