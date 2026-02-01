import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:uniordle/core/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/services/stats_manager.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await statsManager.init();

  final settingsController = SettingsController();
  await settingsController.loadSettings();

  await SoundManager().init();

  runApp(
    Phoenix(
      child: const App(),
    ),
  );

  doWhenWindowReady(() {
    const double widthOverhead = 16.0; 
    const double heightOverhead = 32.0;

    final minSize = Size(
      AppLayout.minAppWidth + widthOverhead, 
      AppLayout.minAppHeight + heightOverhead
    );
      final startSize = Size(
      AppLayout.maxAppWidth + widthOverhead, 
      AppLayout.startAppHeight + heightOverhead
    );

    appWindow.minSize = minSize;
    appWindow.size = startSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Uniordle';
    appWindow.show();
  });
}