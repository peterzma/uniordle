import 'package:uniordle/core/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/services/stats_manager.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

const Size desktopMinSize = Size(AppLayout.minAppWidth, 960);
const Size desktopStartSize = Size(AppLayout.minAppWidth, 960);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await statsManager.init();

  final settingsController = SettingsController();
  await settingsController.loadSettings();

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