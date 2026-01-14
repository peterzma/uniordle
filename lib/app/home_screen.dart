import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeScreenBackground,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                'Uniordle',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'crashdisplay',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}