import 'package:flutter/material.dart';
import 'package:flutter_wordle/app/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() { 
  runApp(const App()); 

  
  doWhenWindowReady(() {
    appWindow.size = const Size(400, 750);
    appWindow.minSize = const Size(400, 750);
    appWindow.maxSize = const Size(400, 750);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}