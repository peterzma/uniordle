import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onClose;

  const SettingsScreen({super.key, required this.onClose});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsState _settings = SettingsState();

  void _toggleSounds(bool value) {
    setState(() {
      _settings = _settings.copyWith(soundsEnabled: value);
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _settings = _settings.copyWith(darkModeEnabled: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SettingsSectionHeader(title: 'PREFERENCES'),
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
                  const SettingsSectionHeader(title: 'SUPPORT'),
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

  Widget _buildHeader() {
    return BaseHeader(
      title: 'Settings',
      leftIcon: Icons.chevron_left, 
      onLeftTap: widget.onClose,
    );
  }
}