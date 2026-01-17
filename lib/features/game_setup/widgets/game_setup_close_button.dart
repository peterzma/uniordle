import 'package:uniordle/shared/game_setup_exports.dart';

class SettingsCloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsCloseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Close',
        style: GameSetUpFonts.closeButtonText,
      ),
    );
  }
}