import 'package:flutter/material.dart';
import 'package:uniordle/app/home_screen.dart';
import 'package:uniordle/uniordle/views/uniordle_screen.dart';


class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uniordle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: HomeScreen(),
      initialRoute: '/', // start screen
      routes: {
        '/': (context) => const HomeScreen(),
        '/uniordle': (context) => const UniordleScreen(),
      }
    );
  }
}