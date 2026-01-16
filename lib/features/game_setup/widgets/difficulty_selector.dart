import 'package:uniordle/shared/game_setup_exports.dart';

const _labels = {
  1: ('1st Year', '8'),
  2: ('2nd Year', '7'),
  3: ('3rd Year', '6'),
  4: ('Postgrad', '5'),
};

class DifficultySelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const DifficultySelector({
    super.key, 
    required this.value, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'YEAR LEVEL',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite, 
              color: Colors.blue.shade300,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'ATTEMPTS ALLOWED',
              style: TextStyle(
                color: Colors.blue.shade300,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: Colors.white24,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
            overlayColor: Colors.white.withValues(alpha: 0.1),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 3),
            activeTickMarkColor: Colors.white54,
            inactiveTickMarkColor: Colors.white54,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 4,
            divisions: 3,
            onChanged: (v) => onChanged(v.round()),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _labels.entries.map((e) {
              final active = e.key == value;
              return Column(
                children: [
                  Text(
                    e.value.$1,
                    style: TextStyle(
                      color: active ? Colors.white : Colors.white54,
                      fontSize: 13,
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        e.value.$2,
                        style: TextStyle(
                          color: active ? Colors.blue.shade300 : Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.favorite,
                        color: active ? Colors.blue.shade300 : Colors.white54,
                        size: 12,
                      )
                    ]
                  )
                ],
              );
            }).toList()
          ),
        ),
      ],
    );
  }
}