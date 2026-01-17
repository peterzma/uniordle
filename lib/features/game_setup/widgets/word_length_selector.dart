import 'package:uniordle/shared/game_setup_exports.dart';

class WordLengthSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  static const _activeColor = Color(0xFF38BDF8);
  static const _inactiveBg = Color(0x0DFFFFFF);
  static const _inactiveBorder = Color(0x1AFFFFFF);

  const WordLengthSelector({
    super.key, 
    required this.value, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        const Text(
          'WORD LENGTH',
          style: GameSetUpFonts.wordLengthText,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [5, 6, 7].map((len) {
            final active = value == len;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GestureDetector(
                  onTap: () => onChanged(len),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: active ? _activeColor : _inactiveBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active ? _activeColor : _inactiveBorder,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$len',
                            style: GameSetUpFonts.numberOfLettersText,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'LETTERS',
                            style: GameSetUpFonts.lettersText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}