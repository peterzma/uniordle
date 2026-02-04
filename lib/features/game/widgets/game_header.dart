import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/help/views/help_dialog.dart';
import 'package:uniordle/features/settings/controller/settings_controller.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';
import 'package:uniordle/shared/navigation/navigation_item.dart';

class GameHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final SettingsController controller = SettingsController();

  GameHeader({super.key, this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(AppLayout.marginHeight);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Uniordle',
      leftIcon: AppIcons.leftArrow,
      onLeftTap: onBack ?? () => Navigator.maybePop(context),
      actions: [
        // Mute Music Button
        ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, state, _) {
            final isMuted = state.musicVolume <= 0;
            return NavigationItem(
              icon: isMuted ? AppIcons.backgroundMusicMuted : AppIcons.backgroundMusic,
              onTap: controller.toggleMusicMute,
              color: isMuted ? AppColors.onSurfaceVariant : AppColors.accent,
            );
          },
        ),
        NavigationItem(
          icon: AppIcons.help,
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => const HelpDialog(),
            );
          },
        ),
      ],
    );
  }
}