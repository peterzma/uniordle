import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/features/game_setup/data/difficulty_config.dart';
import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';

class DifficultySelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final Discipline discipline;

  const DifficultySelector({
    super.key, 
    required this.value, 
    required this.onChanged,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 5.0;

    return Column(
      children: [
        Text(
          'YEAR LEVEL',
          style: AppFonts.displayMedium,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.attempts,
              size: 12,
              color: discipline.color,
            ),
            const SizedBox(width: 8),
            Text(
              'ATTEMPTS ALLOWED',
              style: AppFonts.labelMedium.copyWith(color: discipline.color),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: discipline.color,
            inactiveTrackColor: Colors.white24,
            thumbColor: discipline.color,
            overlayColor: Colors.transparent,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: thumbRadius),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3),
            activeTickMarkColor: discipline.color,
            inactiveTickMarkColor: AppColors.onSurfaceVariant,
          ),
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            onChanged: (v) {
              final newValue = v.round();
              
              if (newValue != value) {
                SoundManager().play(SoundType.settings, volumeOverride: 0.5);
                
                onChanged(newValue);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
                return Row(
                  children: DifficultyConfig.levels.entries.map((e) {

                    final active = e.key == value;
                    final isFirst = e.key == 1;
                    final isLast = e.key == 4;
                    return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: e.key == 2 ? 30.0 : 0.0,
                            left: e.key == 3 ? 42.0 : 0.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isFirst 
                              ? CrossAxisAlignment.start 
                              : isLast 
                                  ? CrossAxisAlignment.end 
                                  : CrossAxisAlignment.center,
                            children: [
                              Text(
                                e.value.$1,
                                textAlign: TextAlign.center,
                                style: active
                                    ? AppFonts.labelMedium.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
                                    : AppFonts.labelMedium,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: isFirst 
                                  ? MainAxisAlignment.start 
                                  : isLast 
                                      ? MainAxisAlignment.end 
                                      : MainAxisAlignment.center,
                                children: [
                                  Transform.translate(
                                    offset: const Offset(0, -1.0),
                                    child: Text(
                                      e.value.$2,
                                      style: active
                                          ? AppFonts.labelMedium.copyWith(color: discipline.color, fontWeight: FontWeight.w600)
                                          : AppFonts.labelMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    AppIcons.attempts,
                                    size: 12,
                                    color: active
                                        ? discipline.color
                                        : AppColors.onSurfaceVariant,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      );
                  }).toList()
                );
            }
          ),
        )
      ],
    );
  }
}