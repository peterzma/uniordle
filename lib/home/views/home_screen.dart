import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/fields/widgets/footer.dart';
import 'package:uniordle/fields/widgets/header.dart';
import 'package:uniordle/fields/widgets/hero_section.dart';

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

  void _onTabChange(String tabId) => setState(() => _activeTab = tabId);

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
                  const HomeHeader(),
                  const SizedBox(height: 24),
                  const HeroSection(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: HomeFooter(activeTab: _activeTab, onTabChange: _onTabChange),
    );
  }
}