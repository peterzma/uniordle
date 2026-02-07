import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;

  const SettingsActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SelectButtonWrapper(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppLayout.settingsPadding),
        decoration: BoxDecoration(
          color: context.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                context.autoIcon(
                  icon,
                  color: context.colorScheme.onSurfaceVariant,
                  size: 24,
                ),
                const SizedBox(width: 16),
                context.autoText(label, style: context.labelLarge),
              ],
            ),
            Row(
              children: [
                if (value != null) Text(value!, style: context.labelSmall),
                if (value != null) const SizedBox(width: 8),
                Icon(
                  AppIcons.navForward,
                  color: context.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
