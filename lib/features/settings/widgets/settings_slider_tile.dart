import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsSliderTile extends StatelessWidget {
  final IconData icon;
  final IconData muteIcon;
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final VoidCallback onMuteToggle;

  const SettingsSliderTile({
    super.key,
    required this.icon,
    required this.muteIcon,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onMuteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppLayout.settingsPadding),
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onMuteToggle,
                    child: context.autoIcon(
                      value > 0 ? icon : muteIcon,
                      color: value > 0
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 12),
                  context.autoText(label, style: AppFonts.labelLarge),
                ],
              ),
              context.autoText(
                '${(value * 100).toInt()}%',
                style: AppFonts.labelMedium,
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              activeTrackColor: context.colorScheme.primary,
              inactiveTrackColor: context.colorScheme.onSurfaceVariant,
              thumbColor: context.colorScheme.onSurface,
              overlayColor: Colors.transparent,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              tickMarkShape: SliderTickMarkShape.noTickMark,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: Slider(value: value, min: 0, max: 1, onChanged: onChanged),
            ),
          ),
        ],
      ),
    );
  }
}
