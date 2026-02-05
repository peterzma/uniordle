import 'package:flutter/material.dart';

class PulsingButtonWrapper extends StatefulWidget {
  final Widget child;
  final Color glowColor;

  const PulsingButtonWrapper({super.key, required this.child, required this.glowColor});

  @override
  State<PulsingButtonWrapper> createState() => PulsingButtonWrapperState();
}

class PulsingButtonWrapperState extends State<PulsingButtonWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(100),
          ),
          child: ScaleTransition(scale: _scale, child: widget.child),
        );
      },
    );
  }
}