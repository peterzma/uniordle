import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            bottom: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ),
          _buildCampusGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
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
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CampusCard(
            university: universities[index],
            onTap: () =>
                _showPlayDialog(context, universities[index].name),
          );
        },
        childCount: universities.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
    ),
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

  void _showPlayDialog(BuildContext context, String universityName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F2B),
        title: Text(universityName, style: const TextStyle(color: Colors.white)),
        content: const _DialogContent(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () => Navigator.pushNamed(context, '/uniordle'),
            child: const Text('PLAY', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
class _DialogContent extends StatelessWidget {
  const _DialogContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildToggleRow('Option 1', false),
        _buildToggleRow('Option 2', true),
      ],
    );
  }

  Widget _buildToggleRow(String title, bool value) {
    return Row(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const Spacer(),
        Switch(value: value, onChanged: (_) {}),
      ],
    );
  }
}