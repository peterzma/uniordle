import 'package:uniordle/shared/exports/settings_exports.dart';
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
      backgroundColor: AppColors.mainBackground,
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

                  const SettingsSectionHeader(title: 'SUPPORT & LEGAL'),
                  SettingsCard(
                    children: [
                      SettingsActionTile(
                        icon: Icons.info_outline_rounded,
                        label: 'About Uniordle',
                        value: 'v1.0.0',
                        onTap: () {
                        },
                        isLast: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildSignOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.backgroundBorder.withValues(alpha: 0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.onClose,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.chevron_left, color: AppColors.textPrimary, size: 28),
            ),
          ),
          const Text(
            'Settings',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 40)
        ],
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.red.withValues(alpha: 0.2),
          highlightColor: Colors.red.withValues(alpha: 0.1),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Sign Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}