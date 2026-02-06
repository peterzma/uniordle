import 'dart:ui';
import 'package:flutter/material.dart';

Route slideUpRoute(Widget page) {
  return PageRouteBuilder(
    opaque: false,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 175),
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, animation, _, child) {
      final scale = Tween<double>(
        begin: 0.95,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ),
      );

      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5 * animation.value,
              sigmaY: 5 * animation.value,
            ),
            child: Container(
              color: Colors.black.withValues(alpha: 0.1 * animation.value),
            ),
          ),

          ScaleTransition(
            scale: scale,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 6 * (1 - animation.value),
                sigmaY: 6 * (1 - animation.value),
              ),
              child: child,
            ),
          ),
        ],
      );
    },
  );
}
