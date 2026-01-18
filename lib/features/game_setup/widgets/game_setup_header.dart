import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class SettingsHeader extends StatelessWidget implements PreferredSizeWidget {
  const SettingsHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Uniordle',
      leftIcon: LucideIcons.chevronLeft,
      onLeftTap: () => Navigator.of(context).pop(),
      height: 72,
    );
  }
}