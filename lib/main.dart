import 'package:flutter/material.dart';
import 'package:uniordle/app/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

const Size desktopMinSize = Size(540, 960);
const Size desktopStartSize = Size(540, 960);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());

  doWhenWindowReady(() {
    appWindow.minSize = desktopMinSize;
    appWindow.size = desktopStartSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Uniordle';
    appWindow.show();
  });
}