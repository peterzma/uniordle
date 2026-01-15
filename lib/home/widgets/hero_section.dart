import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build (BuildContext context) {
    return const Column(
      children: [
        Text(
          'Select Discipline',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Master your academic vocabulary.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}