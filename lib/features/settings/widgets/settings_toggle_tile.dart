import 'package:flutter/cupertino.dart';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.r(16)),
      height: AppLayout.settingsTileHeight,
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
              context.autoIcon(icon, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 12),
              context.autoText(label, style: AppFonts.labelLarge),
            ],
          ),
          Transform.scale(
            scale: 0.8,
            alignment: Alignment.centerRight,
            child: CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}