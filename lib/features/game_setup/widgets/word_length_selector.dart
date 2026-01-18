import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class WordLengthSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final Discipline discipline;

  const WordLengthSelector({
    super.key, 
    required this.value, 
    required this.onChanged,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Text(
          'WORD LENGTH',
          style: GameSetUpFonts.wordLengthText,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [5, 6, 7].map((len) {
            final bool active = value == len;
            final Color baseColor = active 
                ? discipline.color 
                : AppColors.nonSelectedButton;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: PumpButtonWrapper(
                  onTap: () => onChanged(len),
                  baseColor: baseColor,
                  enableDarken: true,
                  borderRadius: BorderRadius.circular(36),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: active ? discipline.color : AppColors.nonSelectedButton,
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(
                          color: active 
                              ? discipline.color 
                              : AppColors.nonSelectedButtonBorder,
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
                          Text(
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