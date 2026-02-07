import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CelebrationWrapper extends StatefulWidget {
  final Widget child;
  final List<Color>? colors;
  final Duration duration;
  final ConfettiController? externalController;

  const CelebrationWrapper({
    super.key,
    required this.child,
    this.colors,
    this.duration = const Duration(seconds: 2),
    this.externalController,
  });

  @override
  State<CelebrationWrapper> createState() => _CelebrationWrapperState();
}

class _CelebrationWrapperState extends State<CelebrationWrapper> {
  late ConfettiController _internalController;

  ConfettiController get _effectiveController =>
      widget.externalController ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = ConfettiController(duration: widget.duration);

    if (widget.externalController == null) {
      _internalController.play();
    }
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        widget.child,
        ConfettiWidget(
          confettiController: _effectiveController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors:
              widget.colors ??
              [
                Colors.orange,
                Colors.blue,
                Colors.white,
                Colors.red,
                Colors.purple,
              ],
          minimumSize: const Size(6, 6),
          maximumSize: const Size(12, 12),
          gravity: 0.15,
          numberOfParticles: 25,
        ),
      ],
    );
  }
}
