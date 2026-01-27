import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniordle/features/settings/data/data_reset_service.dart';
import 'package:uniordle/features/settings/settings_manager.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint('Could not launch $url');
    }
  }

  void _toggleSounds(bool value) {
    setState(() {
      _settings = _settings.copyWith(soundsEnabled: value);
    });

    settingsNotifier.value = _settings;

    SoundManager().soundsEnabled = value;

    _savePreference('sounds_enabled', value);
  }

  // void _toggleDarkMode(bool value) {
  //   setState(() {
  //     _settings = _settings.copyWith(darkModeEnabled: value);
  //   });

  //   settingsNotifier.value = _settings;

  //   _savePreference('dark_mode_enabled', value);
  // }

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
                  SettingsToggleTile(
                    icon: Icons.volume_up_rounded,
                    label: 'Sound Effects',
                    value: _settings.soundsEnabled,
                    onChanged: _toggleSounds,
                  ),

                  const SettingsHeader(title: 'SOCIALS'),
                  SettingsActionTile(
                    icon: Icons.person_search_rounded,
                    label: 'LinkedIn (Let\'s connect!)',
                    onTap: () => _launchUrl('https://www.linkedin.com/in/peterzma'),
                  ),
                  const SizedBox(height: 8),
                  SettingsActionTile(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onTap: () {
                      _launchUrl('https://github.com/chuckabox');
                    },
                  ),
                  const SizedBox(height: 8),

                  const SettingsHeader(title: 'SUPPORT'),
                  SettingsActionTile(
                    icon: Icons.bug_report_rounded,
                    label: 'Report a Bug',
                    onTap: () => _launchUrl('https://docs.google.com/forms/d/19N6-JRjClBgYyfCR6-PgeSD8mpJWJkswuQcQXo9DE0k/prefill'),
                  ),
                  const SizedBox(height: 8),
                  SettingsActionTile(
                    icon: Icons.lightbulb_outline_rounded,
                    label: 'Feedback',
                    onTap: () => _launchUrl('https://docs.google.com/forms/d/e/1FAIpQLSeTSDNdbh0e0pl3-IbcI9aXB-3vqUnG__bQR57T2AOmz-PgsQ/viewform?usp=pp_url&entry.1189187296=Feedback'),
                  ),
                  const SizedBox(height: 8),
                  SettingsActionTile(
                    icon: Icons.info_outline_rounded,
                    label: 'About Uniordle',
                    value: 'v1.0.0',
                    onTap: () => _showAboutDialog(context),
                  ),

                  const SettingsHeader(title: 'DANGER ZONE'),
                  SettingsActionTile(
                    icon: Icons.delete_forever_rounded,
                    label: 'Clear All Data',
                    onTap: () => DataResetService.showResetDialog(context),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            SettingsSignOutButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => BaseDialog(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Icon
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.school, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 24),
              
              Text("Uniordle", style: AppFonts.displayLarge),
              const SizedBox(height: 12),
          
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppFonts.displayMedium,
                  children: [
                    const TextSpan(text: "A solo project by "),
                    TextSpan(
                      text: "Peter",
                      style: AppFonts.displayMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.inWordColor),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),

              Text(
                "Software Engineering Student @ UQ", 
                style: AppFonts.labelMedium.copyWith(color: AppColors.accent)
              ),
              
              const SizedBox(height: 36),
              
              PrimaryButton(
                onPressed: () => showLicensePage(context: context),
                label: "LICENSES",
                color: AppColors.accent,
              ),
          
              const SizedBox(height: 12),
          
              PrimaryButton(
                onPressed: () => Navigator.pop(context),
                label: "CLOSE",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}