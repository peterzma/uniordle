import 'package:flutter/material.dart';
import 'package:uniordle/core/app_colors.dart';
import 'package:uniordle/features/home/views/home_screen.dart';
import 'package:uniordle/features/game/views/game_screen.dart';
import 'package:uniordle/core/app_fonts.dart';

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
        scaffoldBackgroundColor: AppColors.mainBackground,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.tileNumber,
          headlineMedium: AppTextStyles.gameTitle,
          labelLarge: AppTextStyles.buttonText,
          labelSmall: AppTextStyles.smallLabel,
        ),
      ),

      builder: (context, child) {
        return Material(
          // This color will fill everything OUTSIDE the 540px
          color: AppColors.mainBackground, 
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: ClipRect(child: child!),
            ),
          ),
        );
      },

      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/uniordle': (context) => const UniordleScreen(),
      },
    );
  }
}
