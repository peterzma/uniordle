import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/app/app_colors.dart';


class HomeFooter extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;
  
  const HomeFooter({
    super.key, 
    required this.activeTab, 
    required this.onTabChange
  });

  @override
  Widget build (BuildContext context) {
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
              _navItem('stats', 'Stats', LucideIcons.history),
              _navItem('fields', 'Fields', LucideIcons.layoutGrid),
              _navItem('profile', 'Profile', LucideIcons.user),
            ],
          ),
        ),
      ),
    );
  }


  Widget _navItem(String id, String label, IconData icon) {
    final bool isActive = activeTab == id;
    final Color color = isActive ? AppColors.selectedIcon : AppColors.nonSelectedIcon;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onTabChange(id),
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