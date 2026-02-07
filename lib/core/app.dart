import 'package:uniordle/shared/exports/app_exports.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final MusicNavigationObserver _musicObserver = MusicNavigationObserver();

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

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      SoLoud.instance.setPause;
    } else if (state == AppLifecycleState.resumed) {
      SoLoud.instance.play;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniordle',
      navigatorObservers: [_musicObserver],
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return ResponsiveWrapper(child: child!);
      },

      initialRoute: '/',

      onGenerateRoute: (settings) {
        return InstantPageRoute(settings: settings, page: _getPage(settings));
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
        return Builder(
          builder: (context) {
            return SettingsScreen(onClose: () => Navigator.of(context).pop());
          },
        );

      default:
        return const HomeScreen();
    }
  }
}
