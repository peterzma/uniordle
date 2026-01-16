import 'package:flutter/material.dart';
import 'package:uniordle/app/widgets/game_button_wrapper.dart';

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
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: bottomPadding > 0 ? bottomPadding : 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: isLoading ? null : onPlay,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0A0E17),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}