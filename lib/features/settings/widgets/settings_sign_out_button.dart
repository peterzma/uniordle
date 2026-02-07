import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsSignOutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsSignOutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: PrimaryButton(
        onPressed: onPressed,
        label: 'SIGN OUT',
        color: context.colorScheme.error,
      ),
    );
  }
}
