import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';
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
    return Container(
      height: AppLayout.settingsTileHeight,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surface.withValues(alpha: 0.6)),
      ),
      child: SelectButtonWrapper(
        onTap: onTap,
        pressScale: 0.99,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.onSurfaceVariant, size: 24),
                  const SizedBox(width: 12),
                  Text(label, style: AppFonts.labelLarge),
                ],
              ),
              Row(
                children: [
                  if (value != null)
                    Text(value!, style: AppFonts.labelSmall),
                  if (value != null) const SizedBox(width: 8),
                  Icon(
                    AppIcons.settingsRightArrow,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}