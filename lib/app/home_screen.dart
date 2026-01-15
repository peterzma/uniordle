import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/app/app_layout.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'campus';

  final List<Map<String, dynamic>> _tabs = [
    {'id': 'campus', 'label': 'CAMPUS', 'icon': LucideIcons.graduationCap},
    {'id': 'archive', 'label': 'ARCHIVE', 'icon': LucideIcons.library},
    {'id': 'profile', 'label': 'PROFILE', 'icon': LucideIcons.user},
  ];

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
      backgroundColor: Color(0xFF0A0E17),
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
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              LucideIcons.settings,
              color: Colors.grey,
              size: 24,
            ),
            onPressed: () {}, // add functionality later
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      children: [
        const Text(
          'Campuses',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Select a University to begin.',
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

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E17).withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: Colors.white10, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tabs.map((tab) {
            final bool isActive = _activeTab == tab['id'];
            final Color color = isActive ? Colors.blue : Colors.grey;

            return GestureDetector(
              onTap: () => setState(() => _activeTab = tab['id']),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tab['icon'],
                    color: color,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tab['label'],
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      )
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