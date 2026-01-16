import 'package:uniordle/uniordle/uniordle.dart';

class UniordleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UniordleAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(128);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Uniordle',
        style: TextStyle(
          fontSize: 72,
          fontFamily: 'clashdisplay',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}