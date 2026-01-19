import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:uniordle/shared/layout/base_header.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Settings', 
      leftIcon: LucideIcons.chevronLeft, 
      onLeftTap: () => Navigator.of(context).pop(),
    );
  }
}