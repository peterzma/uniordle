import 'package:auto_size_text/auto_size_text.dart';
import 'package:uniordle/shared/exports/app_exports.dart';
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
    final bool isNarrow = AppLayout.mobileMode(context);
    return Column(
      children: [
        Text(
          'WORD LENGTH',
          style: AppFonts.displayMedium,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [5, 6, 7].map((len) {
            final bool active = value == len;
            final Color baseColor = active 
                ? discipline.color 
                : AppColors.surfaceVariant;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: SelectButtonWrapper(
                  onTap: () => onChanged(len),
                  soundType: SoundType.settings,
                  baseColor: baseColor,
                  enableDarken: true,
                  borderRadius: BorderRadius.circular(36),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: active ? discipline.color : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            '$len',
                            style: active 
                            ? AppFonts.displayMedium.copyWith(fontWeight: FontWeight.w900)
                            : AppFonts.displayMedium,
                          ),
                          AutoSizeText(
                            'LETTERS',
                            style: active 
                            ? AppFonts.labelMedium.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w600)
                            : AppFonts.labelMedium,
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