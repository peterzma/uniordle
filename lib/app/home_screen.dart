import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/app/responsive_wrapper.dart';
import 'package:uniordle/uniordle/widgets/campus_card.dart';
import 'package:uniordle/uniordle/data/university_data.dart';

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

  final List<Map<String, dynamic>> _navigationTabs = const [
    {'id': 'campus', 'label': 'CAMPUS', 'icon': LucideIcons.graduationCap},
    {'id': 'archive', 'label': 'ARCHIVE', 'icon': LucideIcons.library},
    {'id': 'profile', 'label': 'PROFILE', 'icon': LucideIcons.user},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gameBackground,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              color: AppColors.gameBackground,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  _buildCampusGrid(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopOverlay() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        color: AppColors.gameBackground,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(LucideIcons.settings, color: Colors.grey, size: 24),
          _buildLogo(),
          const Icon(LucideIcons.barChart3, color: Colors.grey, size: 24),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        const Text(
          'Uniordle',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          height: 2,
          width: 40,
          margin: const EdgeInsets.only(top: 4),
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return const Column(
      children: [
        Text(
          'Campuses',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 8),
        Text(
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

  Widget _buildCampusGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,  
      ),
      itemCount: universities.length,
      itemBuilder: (context, index) {
        return CampusCard(
          university: universities[index],
          onTap: () => _showSettingsDialog(context, universities[index].name),
        );
      },
    );
  }


  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E17).withValues(alpha: 0.95),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navigationTabs.map((tab) => _buildNavItem(tab)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(Map<String, dynamic> tab) {
    final bool isActive = _activeTab == tab['id'];
    final Color color = isActive ? Colors.blue : Colors.grey;

    return InkWell(
      onTap: () => setState(() => _activeTab = tab['id']),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tab['icon'], color: color, size: 28),
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