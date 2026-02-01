import 'dart:developer';
import 'package:flutter_soloud/flutter_soloud.dart';

enum SoundType {
  click,
  keyboard,
  delete,
  enter,
  hover,
  settings,
  menuMusic,
  gameMusic,
}

class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;
  SoundManager._internal();

  final Map<SoundType, AudioSource> _sources = {};

  final Map<SoundType, double> _volumes = {
    SoundType.click: 0.4,
    SoundType.keyboard: 0.4,
    SoundType.delete: 0.2,
    SoundType.enter: 0.2,
    SoundType.hover: 0.4,
    SoundType.settings: 0.4,
  };

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await SoLoud.instance.init();
      
      _sources[SoundType.click] = await SoLoud.instance.loadAsset('assets/audio/click.mp3');
      _sources[SoundType.keyboard] = await SoLoud.instance.loadAsset('assets/audio/keyboard_tap.mp3');
      _sources[SoundType.delete] = await SoLoud.instance.loadAsset('assets/audio/special_key.mp3');
      _sources[SoundType.enter] = await SoLoud.instance.loadAsset('assets/audio/special_key.mp3');
      _sources[SoundType.hover] = await SoLoud.instance.loadAsset('assets/audio/hover.mp3');
      _sources[SoundType.settings] = await SoLoud.instance.loadAsset('assets/audio/click.mp3');

      _isInitialized = true;
    } catch (e) {
      log('Audio Init Error: $e');
    }
  }

  bool _enabled = true;

  set soundsEnabled(bool value) => _enabled = value;

  void play(SoundType type, {double? volumeOverride}) {
    if (!_isInitialized || !_enabled) return;
    
    final source = _sources[type];
    if (source != null) {

      final double vol = volumeOverride ?? _volumes[type] ?? 1.0;

      SoLoud.instance.play(source, volume: vol);
    }
  }

  void dispose() {
    SoLoud.instance.deinit();
  }
}