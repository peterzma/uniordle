import 'package:flutter/material.dart';
import 'play_button.dart';
import 'close_button.dart';

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
        bottom: bottomPadding > 0 ? bottomPadding : 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlayButton(isLoading: isLoading, onPressed: onPlay),
          const SizedBox(height: 8),
          SettingsCloseButton(onPressed: onClose),
        ],
      ),
    );
  }
}