import 'package:flutter/material.dart';

/// Global layout constants for Uniordle.
/// Keep all fixed sizing rules here.
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveWrapper({
    super.key, 
    required this.child, 
    this.maxWidth = 540,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}