import 'package:flutter/material.dart';
import 'package:uniordle/app/home_screen.dart';
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
      /// Application title in OS task switcher
      title: 'Uniordle',
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      /// Initial home screen displayed
      initialRoute: '/',
      /// Named routes for navication
      routes: {
        '/': (context) => const HomeScreen(),
        '/uniordle': (context) => const UniordleScreen(),
      },
    );
  }
}