import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';
import 'package:uniordle/features/settings/screens/settings_screen.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Uniordle',
      leftIcon: LucideIcons.settings,
      onLeftTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingsScreen(
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
      rightIcon: LucideIcons.helpCircle,
      onRightTap: () {
        // help logic here
      },
    );
  }
}
