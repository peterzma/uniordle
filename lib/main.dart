import 'package:uniordle/core/app.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniordle/features/profile/controller/stat_manager.dart';
import 'package:uniordle/features/settings/settings_manager.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

const Size desktopMinSize = Size(AppLayout.minAppWidth, 960);
const Size desktopStartSize = Size(AppLayout.minAppWidth, 960);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  await statsManager.init();

  final bool savedSounds = prefs.getBool('sounds_enabled') ?? true;
  final bool savedDarkMode = prefs.getBool('dark_mode_enabled') ?? true;

  settingsNotifier.value = SettingsState(
    soundsEnabled: savedSounds,
    darkModeEnabled: savedDarkMode,
  );

  await SoundManager().init();
  SoundManager().soundsEnabled = savedSounds;

  runApp(const App());

  doWhenWindowReady(() {
    appWindow.minSize = desktopMinSize;
    appWindow.size = desktopStartSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Uniordle';
    appWindow.show();
  });
}