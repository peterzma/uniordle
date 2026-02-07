import 'package:uniordle/shared/exports/game_setup_exports.dart';

class WordLengthSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final Major major;

  const WordLengthSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [5, 6, 7].map((len) {
            final bool active = value == len;
            final Color baseColor = active
                ? major.color
                : context.surfaceVariant;
            return Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 160),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.r(8)),
                    child: SelectButtonWrapper(
                      onTap: () => onChanged(len),
                      soundType: SoundType.gameSettings,
                      baseColor: baseColor,
                      enableDarken: true,
                      borderRadius: BorderRadius.circular(36),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: active
                                ? major.color
                                : context.surfaceVariant,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                '$len',
                                style: active
                                    ? AppFonts.displayMedium.copyWith(
                                        fontWeight: FontWeight.w900,
                                      )
                                    : AppFonts.displayMedium,
                              ),
                              AutoSizeText(
                                'LETTERS',
                                style: active
                                    ? AppFonts.labelMedium.copyWith(
                                        color: context.colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : AppFonts.labelMedium,
                              ),
                            ],
                          ),
                        ),
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
