import 'package:flutter/material.dart';
import 'package:uniordle/app/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/app/app_layout.dart';

const double appWidth = 540;

void main() {
  
  runApp(const App());
  

  doWhenWindowReady(() {
    appWindow.size = const Size(AppLayout.minWidth, 960);
    appWindow.minSize = const Size(AppLayout.minWidth, 960);
    // appWindow.maxSize = Size(1080, 960);
    appWindow.alignment = Alignment.center;
    appWindow.title = "Uniordle";
    appWindow.show();
    
  });
}