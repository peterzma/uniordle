import 'package:uniordle/shared/exports/game_setup_exports.dart';

class DifficultySelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final Major major;

  const DifficultySelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    final levels = DifficultyConfig.levels.entries.toList();
    final bool mobileMode = AppLayout.mobileMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.gameAttempts, size: 12, color: major.color),
            SizedBox(width: context.r(8)),
            Text(
              'ATTEMPTS ALLOWED',
              style: AppFonts.labelMedium.copyWith(color: major.color),
            ),
          ],
        ),
        SizedBox(height: context.r(8)),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: major.color,
            inactiveTrackColor: context.colorScheme.onSurfaceVariant,
            thumbColor: major.color,
            overlayColor: Colors.transparent,
            overlayShape: RoundSliderOverlayShape(
              overlayRadius: mobileMode ? 40 : 60,
            ),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3.0),
            activeTickMarkColor: major.color,
            inactiveTickMarkColor: context.colorScheme.onSurfaceVariant,
          ),
          child: SizedBox(
            height: 20,
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              onChanged: (v) {
                final newValue = v.round();

                if (newValue != value) {
                  SoundManager().play(SoundType.gameSettings);

                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
        Row(
          children: levels.map((e) {
            final active = e.key == value;

            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeText(
                    mobileMode
                        ? e.value.$1.replaceAll(' Year', '').trim()
                        : e.value.$1,
                    textAlign: TextAlign.center,
                    minFontSize: 8,
                    maxLines: 1,
                    style: active
                        ? AppFonts.labelMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )
                        : AppFonts.labelMedium.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        e.value.$2.toString(),
                        style: active
                            ? AppFonts.labelMedium.copyWith(
                                color: major.color,
                                fontWeight: FontWeight.w600,
                              )
                            : AppFonts.labelMedium,
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        AppIcons.gameAttempts,
                        size: 12,
                        color: active
                            ? major.color
                            : context.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
