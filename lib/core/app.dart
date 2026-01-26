import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/core/app_theme.dart';
import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/settings/screens/settings_screen.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

/// Root widget of Uniordle
/// 
/// Sets up theme, routes, and initial home screen
class App extends StatelessWidget {
  const App({
    super.key,
  });

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
        return const HomeScreen();
      case '/uniordle':
        return const GameScreen();
      case '/setup':
        final args = settings.arguments as Discipline;
        return GameSetupScreen(discipline: args);
      case '/settings':
        return Builder(builder: (context) {
          return SettingsScreen(
            onClose: () => Navigator.of(context).pop(),
          );
        });
      case '/profile':
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }
}

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface, 
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.minAppWidth),
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}

class InstantPageRoute extends PageRouteBuilder {
  final Widget page;

  InstantPageRoute({
    required this.page, super.settings
  }): super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
}