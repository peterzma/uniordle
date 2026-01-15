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
    final logos = [
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'University of Adelaide',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'Australian National University',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'University of Melbourne',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'Monash University',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'UNSW Sydney',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'University of Queensland',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'University of Sydney',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'Queensland University of Technology',
      },
      {
        'path': 'assets/images/uq_logo.png',
        'name': 'University of Tasmania',
      },
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
        child: LayoutBuilder(
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
                children: logos.map((logo) {
                  return _buildLogo(
                    logo['path'] as String,
                    logo['name'] as String,
                    context,
                  );
                  }).toList(),
                ),
              );
          }
        ),
      ),
    );
  }

  Widget _buildLogo(String assetPath, String label, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(46),
          child: InkWell (
            borderRadius: BorderRadius.circular(46),
            onTap: () => _showSettingsDialog(context, label),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
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

  void _showSettingsDialog(BuildContext context, String university) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(university),
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
            child: const Text('CLOSE'),
          ),
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
    );
  }
}