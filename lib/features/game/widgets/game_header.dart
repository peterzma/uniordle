import 'package:uniordle/features/home/widgets/help/help_dialog.dart';
import 'package:uniordle/shared/exports/game_screen_exports.dart';
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
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Uniordle',
      leftIcon: LucideIcons.arrowLeft,
      onLeftTap: () => Navigator.maybePop(context),
      rightIcon: LucideIcons.helpCircle,
      onRightTap: () {
          showDialog(
          context: context,
          barrierDismissible: true, 
          barrierColor: Colors.black.withValues(alpha: 0.4),
          builder: (context) => const HelpDialog(),
        );
      }
    );
  }
}