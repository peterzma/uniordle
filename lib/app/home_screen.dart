import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/app/app_layout.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final logoPaths = [
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
      'assets/images/uq_logo.png',
    ];

    return Scaffold(
      backgroundColor: homeScreenBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 128,
        title: const Text(
            'Uniordle',
            style: TextStyle(
              fontSize: 72,
              fontFamily: 'clashdisplay',
              fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showSettingsDialog(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final double maxWidth = constraints.maxWidth.clamp(400, 444);
                  return SizedBox(
                    width: maxWidth,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                      children: logoPaths.map((path) => _buildLogo(path)).toList(),
                    ),
                  );
                }
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, '/uniordle',
                  );
                },
                child: const Text(
                  'PLAY',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'dm-sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildLogo(String assetPath) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 140,
          width: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(46),
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'University of Queensland',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'dm-sans',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Text('Option 1'),
                Spacer(),
                Switch(value: false, onChanged: null),
              ],
            ),
            Row(
              children: const [
                Text('Option 2'),
                Spacer(),
                Switch(value: true, onChanged: null),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}