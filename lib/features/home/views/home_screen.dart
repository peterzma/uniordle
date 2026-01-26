import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/features/home/data/disciplines_data.dart';
import 'package:uniordle/features/profile/views/profile_screen.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeTab = 'home';
  final List<Discipline> _disciplines = DisciplinesData.all;

  void _onDisciplineTap(Discipline sub) {
    Navigator.of(context).pushNamed(
      '/setup',
      arguments: sub, 
    );
  }

  void _onTabChange(String tabId) => setState(() => _activeTab = tabId);

  @override
  Widget build(BuildContext context) {
    Widget activeBody;
    String activeTitle;

    switch (_activeTab) {
      case 'profile':
        activeTitle = 'Profile';
        activeBody = const ProfileScreen();
        break;
      case 'stats':
        activeTitle = 'Statistics';
        activeBody = const Center(child: Text('Stats View')); 
        break;
      case 'home':
      default:
        activeTitle = 'Uniordle';
        activeBody = _buildHomeContent();
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: HomeHeader(title: activeTitle),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppLayout.kSidePadding),
          child: Center(
            child: activeBody,
          ),
        ),
      ),
      bottomNavigationBar: HomeFooter(
        activeTab: _activeTab, 
        onTabChange: _onTabChange,
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HomeHero(),
        const SizedBox(height: 36),
        DisciplineGrid(
          disciplines: _disciplines,
          onSubjectTap: _onDisciplineTap,
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}