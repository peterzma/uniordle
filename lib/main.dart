import 'package:flutter/material.dart';
import 'package:uniordle/app/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/app/responsive_wrapper.dart';

const double appWidth = 540;

void main() {
  
  runApp(const App());
  

  doWhenWindowReady(() {
    appWindow.size = const Size(540, 960);
    appWindow.minSize = const Size(540, 960);
    // appWindow.maxSize = Size(1080, 960);
    appWindow.alignment = Alignment.center;
    appWindow.title = "Uniordle";
    appWindow.show();
    
  });
}