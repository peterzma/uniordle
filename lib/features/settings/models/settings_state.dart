class SettingsState {
  final bool soundsEnabled;
  final bool musicEnabled;
  final bool darkModeEnabled;

  SettingsState({
    this.soundsEnabled = true,
    this.musicEnabled = true,
    this.darkModeEnabled = true,
  });

  SettingsState copyWith({bool? soundsEnabled, bool? musicEnabled, bool? darkModeEnabled}) {
    return SettingsState(
      soundsEnabled: soundsEnabled ?? this.soundsEnabled,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }
}