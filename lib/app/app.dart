import 'package:flutter/material.dart';
import 'package:uniordle/fields/views/field_screen.dart';
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
        '/': (context) => const MaxWidthLayout(
          child: HomeScreen(),
        ),
        '/uniordle': (context) => const MaxWidthLayout(
          child: UniordleScreen(),
        ),
      },
    );
  }
}

class MaxWidthLayout extends StatelessWidget {
  const MaxWidthLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 540,
          ),
          child: child,
        ),
      ),
    );
  }
}
