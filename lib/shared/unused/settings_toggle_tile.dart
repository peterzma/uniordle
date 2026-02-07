import 'package:uniordle/shared/exports/core_exports.dart';
import 'package:flutter/cupertino.dart';

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
              ),
              const SizedBox(width: 12),
              context.autoText(label, style: context.labelLarge),
            ],
          ),
          SizedBox(
            height: context.responsive(20, 32),
            child: FittedBox(
              fit: BoxFit.contain,
              child: CupertinoSwitch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: context.colorScheme.primary,
                inactiveTrackColor: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
