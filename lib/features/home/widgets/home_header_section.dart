import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BaseHeader(
        title: 'Uniordle',
        leftIcon: LucideIcons.settings,
        onLeftTap: () {
          Navigator.of(context).pushNamed('/settings');
        },
        rightIcon: LucideIcons.helpCircle,
        onRightTap: () {
          // help logic here
        },
      ),
    );
  }
}
