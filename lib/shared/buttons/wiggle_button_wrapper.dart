import 'package:uniordle/shared/exports/home_exports.dart';
import 'dart:math';

class WiggleButtonWrapper extends StatefulWidget {
  final Widget child;

  const WiggleButtonWrapper({super.key, required this.child});

  @override
  State<WiggleButtonWrapper> createState() => _WiggleWrapperState();
}

class _WiggleWrapperState extends State<WiggleButtonWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
  }

  void _wiggle() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _wiggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Sine wave formula for the shake effect
          // (3 * 2 * pi) gives 3 full oscillations
          final double offset = sin(_controller.value * 6 * pi) * 4 * (1 - _controller.value);
          
          return Transform.translate(
            offset: Offset(offset, 0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}