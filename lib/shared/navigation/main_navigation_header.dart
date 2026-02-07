import 'package:uniordle/shared/exports/core_exports.dart';
import 'package:uniordle/features/help/views/help_dialog.dart';

class MainNavigationHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const MainNavigationHeader({super.key, this.title = 'Uniordle'});

  @override
  Size get preferredSize => const Size.fromHeight(AppLayout.marginHeight);

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: title,
      leftIcon: AppIcons.navSettings,
      onLeftTap: () {
        Navigator.of(context).pushNamed('/settings');
      },
      rightIcon: AppIcons.navHelp,
      onRightTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          builder: (context) => const HelpDialog(),
        );
      },
    );
  }
}
