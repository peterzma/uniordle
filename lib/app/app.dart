import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/home/views/home_screen.dart';
import 'package:uniordle/uniordle/views/uniordle_screen.dart';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.homeScreenBackground,
      ),

      builder: (context, child) {
        return Scaffold(
          // This color will fill everything OUTSIDE the 540px
          backgroundColor: AppColors.homeScreenBackground, 
          body: Center(
            child: Container(
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
