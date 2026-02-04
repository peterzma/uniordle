import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/navigation/instant_page_route.dart';
import 'package:uniordle/shared/navigation/main_navigation_screen.dart';
import 'package:uniordle/shared/responsive/responsive_wrapper.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      SoLoud.instance.setPause;
    } else if (state == AppLifecycleState.resumed) {
      SoLoud.instance.play;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniordle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

      builder: (context, child) {
        return ResponsiveWrapper(child: child!);
      },

      initialRoute: '/',

      onGenerateRoute: (settings) {
        return InstantPageRoute(
          settings: settings,
          page: _getPage(settings),
        );
      },
    );
  }

  Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return const MainNavigationScreen();
      case '/uniordle':
        return const GameScreen();
      case '/setup':
        final args = settings.arguments as Major;
        return GameSetupScreen(major: args);
      case '/settings':
        return Builder(builder: (context) {
          return SettingsScreen(
            onClose: () => Navigator.of(context).pop(),
          );
        });
      default:
        return const HomeScreen();
    }
  }
}