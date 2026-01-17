import 'package:uniordle/shared/game_screen_exports.dart';
import 'package:uniordle/shared/widgets/base_header.dart';

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
        // help logic here
      },
    );
  }
}