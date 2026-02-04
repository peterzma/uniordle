import 'package:uniordle/features/profile/views/profile_screen.dart';
import 'package:uniordle/features/stats/views/stats_screen.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String _activeTab = 'home';

  void _onTabChange(String tabId) => setState(() => _activeTab = tabId);

  @override
  void initState() {
    super.initState();
    SoundManager().playMusic(SoundType.menuMusic);
  }

  @override
  Widget build(BuildContext context) {
    Widget activeBody;
    String activeTitle;

    switch (_activeTab) {
      case 'stats':
        activeTitle = 'Statistics';
        activeBody = const StatsScreen();
        break;
      case 'profile':
        activeTitle = 'Profile';
        activeBody = const ProfileScreen();
        break;
      case 'home':
      default:
        activeTitle = 'Uniordle';
        activeBody = const HomeScreen();
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: MainNavigationHeader(title: activeTitle),
      body: activeBody,
      bottomNavigationBar: MainNavigationFooter(
        activeTab: _activeTab,
        onTabChange: _onTabChange,
      ),
    );
  }
}