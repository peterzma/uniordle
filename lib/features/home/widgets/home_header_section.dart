import 'package:uniordle/shared/home_screen_exports.dart';
import 'package:uniordle/shared/widgets/base_header.dart';

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
        // settings logic here
      },
      rightIcon: LucideIcons.helpCircle,
      onRightTap: () {
        // help logic here
      },
    );
  }
}
