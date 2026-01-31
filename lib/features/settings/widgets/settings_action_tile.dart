import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
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
        padding: EdgeInsets.all(context.responsive(16, 20)),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surface.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                context.autoIcon(icon, color: AppColors.onSurfaceVariant, size: 24),
                const SizedBox(width: 12),
                context.autoText(label, style: AppFonts.labelLarge),
              ],
            ),
            Row(
              children: [
                if (value != null)
                  Text(value!, style: AppFonts.labelSmall),
                if (value != null) const SizedBox(width: 8),
                Icon(
                  AppIcons.settingsRightArrow,
                  color: AppColors.onSurfaceVariant,
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