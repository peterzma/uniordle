import 'package:uniordle/features/help/screen/help_dialog.dart';
import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

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
          Navigator.of(context).pushNamed('/settings');
        },
        rightIcon: LucideIcons.helpCircle,
        onRightTap: () {
          showDialog(
          context: context,
          barrierDismissible: true, 
          barrierColor: Colors.black.withValues(alpha: 0.4),
          builder: (context) => const HelpDialog(),
        );
      },
    );
  }
}
