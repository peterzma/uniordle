import 'package:flutter/material.dart';
import 'package:uniordle/core/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/core/sound_manager.dart';

const Size desktopMinSize = Size(540, 960);
const Size desktopStartSize = Size(540, 960);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SoundManager().init();

  runApp(const App());

  doWhenWindowReady(() {
    appWindow.minSize = desktopMinSize;
    appWindow.size = desktopStartSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Uniordle';
    appWindow.show();
  });
}