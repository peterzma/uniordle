import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniordle/features/settings/settings_manager.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onClose;

  const SettingsScreen({super.key, required this.onClose});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsState _settings = settingsNotifier.value;

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _toggleSounds(bool value) {
    setState(() {
      _settings = _settings.copyWith(soundsEnabled: value);
    });

    settingsNotifier.value = _settings;

    SoundManager().soundsEnabled = value;

    _savePreference('sounds_enabled', value);
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _settings = _settings.copyWith(darkModeEnabled: value);
    });

    settingsNotifier.value = _settings;

    _savePreference('dark_mode_enabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            BaseHeader(
              title: 'Settings',
              leftIcon: Icons.chevron_left, 
              onLeftTap: widget.onClose,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SettingsHeader(title: 'PREFERENCES'),
                  SettingsCard(
                    children: [
                      SettingsToggleTile(
                        icon: Icons.volume_up_rounded,
                        label: 'Sound Effects',
                        value: _settings.soundsEnabled,
                        onChanged: _toggleSounds,
                      ),
                      SettingsToggleTile(
                        icon: Icons.dark_mode_rounded,
                        label: 'Dark Mode',
                        value: _settings.darkModeEnabled,
                        onChanged: _toggleDarkMode,
                        isLast: true,
                      ),
                    ],
                  ),
                  const SettingsHeader(title: 'SUPPORT'),
                  SettingsCard(
                    children: [
                      SettingsActionTile(
                        icon: Icons.info_outline_rounded,
                        label: 'About Uniordle',
                        value: 'v1.0.0',
                        onTap: () {},
                        isLast: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SettingsSignOutButton(
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}