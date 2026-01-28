import 'package:uniordle/features/settings/data/data_reset_service.dart';
import 'package:uniordle/features/settings/data/link_service.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onClose;
  final SettingsController controller = SettingsController();

  SettingsScreen({
    super.key, required this.onClose
  });

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
              onLeftTap: onClose,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, state, _) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SettingsHeader(title: 'PREFERENCES'),
                      SettingsToggleTile(
                        icon: Icons.volume_up_rounded,
                        label: 'Sound Effects',
                        value: state.soundsEnabled,
                        onChanged: controller.toggleSounds,
                      ),
                      const SettingsHeader(title: 'SOCIALS'),
                      SettingsActionTile(
                        icon: Icons.person_search_rounded,
                        label: 'LinkedIn (Let\'s connect!)',
                        onTap: () => LinkService.launch(LinkService.linkedin),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: Icons.code_rounded,
                        label: 'GitHub',
                        onTap: () => LinkService.launch(LinkService.github),
                      ),
                      const SizedBox(height: 8),
                  
                      const SettingsHeader(title: 'SUPPORT'),
                      SettingsActionTile(
                        icon: Icons.bug_report_rounded,
                        label: 'Report a Bug',
                        onTap: () => LinkService.launch(LinkService.bugReport),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: Icons.lightbulb_outline_rounded,
                        label: 'Feedback',
                        onTap: () => LinkService.launch(LinkService.feedback),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: Icons.info_outline_rounded,
                        label: 'About Uniordle',
                        value: 'v1.0.0',
                        onTap: () => const AboutDialog()
                      ),
                  
                      const SettingsHeader(title: 'DANGER ZONE'),
                      SettingsActionTile(
                        icon: Icons.delete_forever_rounded,
                        label: 'Clear All Data',
                        onTap: () => DataResetService.showResetDialog(context),
                      ),
                      const SizedBox(height: 32),
                    ],
                  );
                }
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
}