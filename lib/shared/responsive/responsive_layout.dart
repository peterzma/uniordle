import 'package:uniordle/core/app_layout.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget smallScreen;
  final Widget largeScreen;

  const ResponsiveLayout({
    super.key,
    required this.smallScreen,
    required this.largeScreen,
  });

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;

    if (windowWidth < AppLayout.breakpoint) {
      return smallScreen;
    }
    return largeScreen;
  }
}