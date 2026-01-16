import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/home/widgets/home/footer.dart';
import 'package:uniordle/home/widgets/home/header.dart';
import 'package:uniordle/home/widgets/home/hero_section.dart';
import 'package:uniordle/home/widgets/home/disciplines/discipline.dart';
import 'package:uniordle/home/models/discipline.dart';

/// The first screen the user sees on opening application
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'home';

    final List<Discipline> disciplines = [
    Discipline(id: '1', name: 'Engineering', icon: 'category', color: Colors.blue),
    Discipline(id: '2', name: 'CS', icon: 'history', color: Colors.red),
    Discipline(id: '3', name: 'Medicine', icon: 'account_circle', tag: 'DONE'),
    Discipline(id: '4', name: 'Law', icon: 'category', count: 12),
  ];

  void _onSubjectTap(Discipline sub) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected ${sub.name}')));
  }

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
                  DisciplineGrid(disciplines: disciplines, onSubjectTap: _onSubjectTap),
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