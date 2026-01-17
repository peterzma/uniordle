import 'package:uniordle/shared/home_screen_exports.dart';
import 'package:uniordle/features/game_setup/views/game_setup_screen.dart';

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
  Discipline(
    id: 'engineering',
    name: 'Engineering',
    icon: 'settings',
    tag: '123 WORDS',
    color: Colors.blue,
  ),
  Discipline(
    id: 'cs',
    name: 'CS',
    icon: 'code',
    tag: '123 WORDS',
    color: Colors.red,
  ),
  Discipline(
    id: 'medicine',
    name: 'Medicine',
    icon: 'heart_pulse',
    tag: '123 WORDS',
    color: Colors.pinkAccent,
  ),
  Discipline(
    id: 'law',
    name: 'Law',
    icon: 'scale',
    tag: '123 WORDS',
    color: Colors.orangeAccent,
  ),
  Discipline(
    id: 'psychology',
    name: 'Psychology',
    icon: 'brain',
    tag: '123 WORDS',
    color: Colors.purpleAccent,
  ),
  Discipline(
    id: 'arts',
    name: 'Arts',
    icon: 'palette',
    tag: '123 WORDS',
    color: Colors.deepPurpleAccent,
  ),
  Discipline(
    id: 'business',
    name: 'Business',
    icon: 'briefcase',
    tag: '123 WORDS',
    color: Colors.greenAccent,
  ),
  Discipline(
    id: 'humanities',
    name: 'Humanities',
    icon: 'book_open',
    tag: '123 WORDS',
    color: Colors.amber,
  ),
  Discipline(
    id: 'education',
    name: 'Education',
    icon: 'graduation_cap',
    tag: '123 WORDS',
    color: Colors.lightBlueAccent,
  ),
  Discipline(
    id: 'maths',
    name: 'Maths',
    icon: 'calculator',
    tag: '123 WORDS',
    color: Colors.deepOrangeAccent,
  ),
  Discipline(
    id: 'music',
    name: 'Music',
    icon: 'music',
    tag: '123 WORDS',
    color: Colors.lime,
  ),
  Discipline(
    id: 'science',
    name: 'Science',
    icon: 'flask_conical',
    tag: '123 WORDS',
    color: Colors.tealAccent,
  ),
  Discipline(
    id: 'design',
    name: 'Design',
    icon: 'pen_tool',
    tag: '123 WORDS',
    color: Colors.cyanAccent,
  ),
  Discipline(
    id: 'architecture',
    name: 'Architecture',
    icon: 'building_2',
    tag: '123 WORDS',
    color: Colors.indigo,
  ),
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
      backgroundColor: AppColors.mainBackground,
      appBar: const HomeHeader(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverSafeArea(
              bottom: false,
              sliver: SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 12),
                    const HeroSection(),
                    const SizedBox(height: 36),
                      DisciplineGrid(
                        disciplines: disciplines, 
                        onSubjectTap: _onDisciplineTap,
                      ),
                  ]),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
      bottomNavigationBar: HomeFooter(
        activeTab: _activeTab, 
        onTabChange: _onTabChange,
      ),
    );
  }
}