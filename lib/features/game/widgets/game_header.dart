import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/features/help/views/help_dialog.dart';

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
      leftIcon: AppIcons.navBack,
      onLeftTap: onBack ?? () => Navigator.maybePop(context),
      actions: [
        // Mute Music Button
        ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, state, _) {
            final isMuted = state.musicVolume <= 0;
            return NavigationItem(
              icon: isMuted ? AppIcons.sysMusicOff : AppIcons.sysMusicOn,
              onTap: controller.toggleMusicMute,
              width: context.responsive(36, 48),
            );
          },
        ),
        NavigationItem(
          icon: AppIcons.navHelp,
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => const HelpDialog(),
            );
          },
          width: context.responsive(36, 48),
        ),
      ],
    );
  }
}
