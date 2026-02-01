import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/help/views/help_dialog.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class GameHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  const GameHeader({
    super.key,
    this.onBack,
    this.onSettings,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppLayout.marginHeight);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Uniordle',
      leftIcon: AppIcons.leftArrow,
      onLeftTap: onBack ?? () => Navigator.maybePop(context),
      rightIcon: AppIcons.help,
      onRightTap: () {
          showDialog(
          context: context,
          barrierDismissible: true, 
          barrierColor: Colors.transparent,
          builder: (context) => const HelpDialog(),
        );
      }
    );
  }
}