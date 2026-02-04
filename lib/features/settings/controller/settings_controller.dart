import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';


class SettingsController {

  static final SettingsController _instance = SettingsController._internal();
  factory SettingsController() => _instance;
  SettingsController._internal();

  final ValueNotifier<SettingsState> _state = ValueNotifier(SettingsState());
  ValueListenable<SettingsState> get state => _state;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    final sounds = prefs.getBool('sounds_enabled') ?? true;
    final music = prefs.getBool('music_enabled') ?? true;
    final darkMode = prefs.getBool('dark_mode_enabled') ?? true;

    _state.value = SettingsState(
      soundsEnabled: sounds,
      musicEnabled: music,
      darkModeEnabled: darkMode,
    );

    SoundManager().soundsEnabled = sounds;
    SoundManager().musicEnabled = music;
  }

  Future<void> toggleSounds(bool value) async {
    _state.value = _state.value.copyWith(soundsEnabled: value);
    SoundManager().soundsEnabled = value;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sounds_enabled', value);
  }

  Future<void> toggleMusic(bool value) async {
    _state.value = _state.value.copyWith(musicEnabled: value);
    SoundManager().musicEnabled = value;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('music_enabled', value);
  }
}