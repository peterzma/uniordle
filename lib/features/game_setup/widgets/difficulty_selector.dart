import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';

const _labels = {
  1: ('1st Year', '8'),
  2: ('2nd Year', '7'),
  3: ('3rd Year', '6'),
  4: ('Postgrad', '5'),
};

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
          style: GameSetUpFonts.yearLevelText,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              GameSetUpFonts.attemptsIcon,
              size: 12,
              color: discipline.color,
            ),
            const SizedBox(width: 8),
            Text(
              'ATTEMPTS ALLOWED',
              style: GameSetUpFonts.attemptsAllowedText(discipline.color),
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
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
                return Row(
                  children: _labels.entries.map((e) {
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
                                    ? GameSetUpFonts.yearLabelActive
                                    : GameSetUpFonts.yearLabelBase,
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
                                          ? GameSetUpFonts.attemptsActiveText(discipline.color)
                                          : GameSetUpFonts.attemptsInactiveText,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    GameSetUpFonts.attemptsIcon,
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