import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/settings/data/data_reset_service.dart';
import 'package:uniordle/features/settings/data/link_service.dart';
import 'package:uniordle/features/settings/widgets/settings_slider_tile.dart';
import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';
import 'package:uniordle/features/settings/widgets/about_dialog.dart';

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
              leftIcon: AppIcons.leftArrow, 
              onLeftTap: onClose,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, state, _) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: AppLayout.pagePadding),
                    children: [
                      const SettingsHeader(title: 'PREFERENCES'),
                      SettingsSliderTile(
                        icon: AppIcons.backgroundMusic,
                        muteIcon: AppIcons.backgroundMusicMuted,
                        label: 'Background Music',
                        value: state.musicVolume,
                        onChanged: controller.setMusicVolume,
                        onMuteToggle: controller.toggleMusicMute,
                      ),
                      const SizedBox(height: 8),
                      SettingsSliderTile(
                        icon: AppIcons.volume,
                        muteIcon: AppIcons.volumeOff,
                        label: 'Sound Effects',
                        value: state.soundVolume,
                        onChanged: controller.setSoundVolume,
                        onMuteToggle: controller.toggleSoundMute,
                      ),
                      const SettingsHeader(title: 'SOCIALS'),
                      SettingsActionTile(
                        icon: AppIcons.linkedIn,
                        label: 'LinkedIn (Let\'s connect!)',
                        onTap: () => LinkService.launch(LinkService.linkedin),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.gitHub,
                        label: 'GitHub',
                        onTap: () => LinkService.launch(LinkService.github),
                      ),
                      const SizedBox(height: 8),
                  
                      const SettingsHeader(title: 'SUPPORT'),
                      SettingsActionTile(
                        icon: AppIcons.bugReport,
                        label: 'Report a Bug',
                        onTap: () => LinkService.launch(LinkService.bugReport),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.feedback,
                        label: 'Feedback',
                        onTap: () => LinkService.launch(LinkService.feedback),
                      ),
                      const SizedBox(height: 8),
                      SettingsActionTile(
                        icon: AppIcons.about,
                        label: 'About Uniordle',
                        value: 'v1.0.0',
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) => const AboutGameDialog(),
                          );
                        },
                      ),
                      const SettingsHeader(title: 'DANGER ZONE'),
                      SettingsActionTile(
                        icon: AppIcons.deleteData,
                        label: 'Clear All Data',
                        onTap: () => DataResetService.showDialog(context),
                      ),
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