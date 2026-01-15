import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uniordle/app/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
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

  Widget _headerIcon({required IconData icon, required VoidCallback onTap}) {
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
          color: Colors.grey
        ),
      ),
    );
  }
}
