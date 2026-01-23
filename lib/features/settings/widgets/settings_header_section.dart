import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({
    super.key, required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8, top: 24),
      child: Text(
        title.toUpperCase(),
        style: AppTextStyles.labelMedium
      ),
    );
  }
}