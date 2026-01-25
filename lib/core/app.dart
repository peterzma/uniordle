import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/features/settings/screens/settings_screen.dart';
import 'package:uniordle/shared/exports/profile_screen_exports.dart';

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
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppTextStyles.uiFont,
      ).copyWith(
        scaffoldBackgroundColor: AppColors.surface,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayMedium,
          headlineMedium: AppTextStyles.displayLarge,
          labelLarge: AppTextStyles.labelLarge,
          labelSmall: AppTextStyles.labelMedium,
        ),
      ),

      builder: (context, child) {
        return ResponsiveWrapper(child: child!);
      },

      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/uniordle': (context) => const UniordleScreen(),
        '/setup': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Discipline;
          return GameSettingsScreen(discipline: args);
        },
        '/settings': (context) => SettingsScreen(
          onClose: () => Navigator.of(context).pop(), 
        ),
        '/profile': (context) => const ProfileView(),
      },
    );
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