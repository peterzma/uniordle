import 'dart:developer';
import 'package:flutter_soloud/flutter_soloud.dart';

class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;
  SoundManager._internal();

  AudioSource? _clickSource;
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await SoLoud.instance.init();
      
      _clickSource = await SoLoud.instance.loadAsset('assets/audio/ui_click.mp3');
      
      _isInitialized = true;
    } catch (e) {
      log('Audio Init Error: $e');
    }
  }

  void playClick() {
    if (!_isInitialized || _clickSource == null) return;

    SoLoud.instance.play(_clickSource!); 
  }

  void dispose() {
    SoLoud.instance.deinit();
  }
}