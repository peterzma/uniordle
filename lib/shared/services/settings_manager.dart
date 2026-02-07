import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:flutter/foundation.dart';

class SettingsController {
  static final SettingsController _instance = SettingsController._internal();
  factory SettingsController() => _instance;
  SettingsController._internal();

  final ValueNotifier<SettingsState> _state = ValueNotifier(SettingsState());
  ValueListenable<SettingsState> get state => _state;

  double _lastMusicVolume = 0.5;
  double _lastSoundVolume = 0.5;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final musicVol = prefs.getDouble('music_volume') ?? 0.5;
    final soundVol = prefs.getDouble('sound_volume') ?? 0.5;
    final darkMode = prefs.getBool('dark_mode_enabled') ?? true;

    _state.value = SettingsState(
      musicVolume: musicVol,
      soundVolume: soundVol,
      darkModeEnabled: darkMode,
    );

    SoundManager().musicVolume = musicVol;
    SoundManager().soundVolume = soundVol;

    if (musicVol > 0) _lastMusicVolume = musicVol;
    if (soundVol > 0) _lastSoundVolume = soundVol;
  }

  Future<void> toggleMusicMute() async {
    if (state.value.musicVolume > 0) {
      _lastMusicVolume = state.value.musicVolume;
      await setMusicVolume(0);
    } else {
      await setMusicVolume(_lastMusicVolume > 0 ? _lastMusicVolume : 0.5);
    }
  }

  Future<void> toggleSoundMute() async {
    if (state.value.soundVolume > 0) {
      _lastSoundVolume = state.value.soundVolume;
      await setSoundVolume(0);
    } else {
      await setSoundVolume(_lastSoundVolume > 0 ? _lastSoundVolume : 0.5);
    }
  }

  Future<void> setMusicVolume(double value) async {
    _state.value = _state.value.copyWith(musicVolume: value);
    SoundManager().musicVolume = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('music_volume', value);
  }

  Future<void> setSoundVolume(double value) async {
    _state.value = _state.value.copyWith(soundVolume: value);
    SoundManager().soundVolume = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sound_volume', value);
  }
}
