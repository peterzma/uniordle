import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'fields';

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
                  _header(),
                  const SizedBox(height: 24),
                  _heroSection(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.gameBackground.withValues(alpha: 0.8),
        border: const Border(
          bottom: BorderSide(color: Color(0xFF1E293B), width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _headerIcon(
            icon: LucideIcons.settings,
            onTap: () {
              // open settings
            },
          ),
          const Text(
            'Uniordle',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          _headerIcon(
            icon: LucideIcons.helpCircle,
            onTap: () {
              // open help
            },
          ),
        ],
      ),
    );
  }
  
  Widget _headerIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 24,
          color: Colors.grey,
        ),
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

  Widget _heroSection() {
    return const Column(
      children: [
        Text(
          'Select Course',
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

  Widget _bottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E17).withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: Colors.white10)
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(
              id: 'stats', 
              label: 'Stats', 
              icon: LucideIcons.history,
              ),
              _navItem(
              id: 'fields', 
              label: 'Fields', 
              icon: LucideIcons.layoutGrid
              ),
              _navItem(
              id: 'profile', 
              label: 'Profile', 
              icon: LucideIcons.user,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required String id,
    required String label,
    required IconData icon,
  }) {
    final bool isActive = _activeTab == id;
    final Color color = isActive ? AppColors.selectedIcon : AppColors.nonSelectedIcon;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => setState(() => _activeTab = id),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.4,
              color: color,
            )
          )
        ]
      )
    );
  }
}