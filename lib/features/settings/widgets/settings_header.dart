import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsHeader extends StatelessWidget {
  final String title;

  const SettingsHeader({
    super.key, required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title.toUpperCase(),
        style: AppFonts.labelMedium
      ),
    );
  }
}