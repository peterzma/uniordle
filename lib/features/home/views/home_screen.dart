import 'package:uniordle/shared/home_screen_exports.dart';
import 'package:uniordle/features/game_setup/views/game_setup_screen.dart';

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
    Discipline(id: 'engineering', name: 'Engineering', icon: 'category', color: Colors.blue),
    Discipline(id: 'cs', name: 'CS', icon: 'history', color: Colors.red),
    Discipline(id: 'medicine', name: 'Medicine', icon: 'account_circle', tag: 'DONE'),
    Discipline(id: 'law', name: 'Law', icon: 'category', count: 12),
  ];

void _onDisciplineTap(Discipline sub) {
  Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => GameSettingsScreen(discipline: sub),
    ),
  );
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
                  DisciplineGrid(disciplines: disciplines, onSubjectTap: _onDisciplineTap),
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