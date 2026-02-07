import 'package:uniordle/shared/exports/help_exports.dart';

class RiseAndReach extends StatelessWidget {
  const RiseAndReach({super.key});

  final List<Map<String, String>> ranks = const [
    {'title': 'UNDERGRADUATE', 'level': 'LEVEL 0+'},
    {'title': 'BACHELOR', 'level': 'LEVEL 10+'},
    {'title': '???', 'level': 'LEVEL ???'}, // CHANCELLOR
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText(
          'RISE & REACH',
          style: AppFonts.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(8)),
        context.autoText(
          'Earn new academic ranks every 10 levels and unlock prestigious titles to become ???',
          style: AppFonts.labelMedium,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        SizedBox(height: context.r(32)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              _buildRankRow(
                context,
                ranks[0],
                color: context.colorScheme.primary,
              ),
              const Divider(color: AppColorsDark.outline, height: 1),

              _buildRankRow(
                context,
                ranks[1],
                color: context.colorScheme.onSurface,
              ),
              const Divider(color: AppColorsDark.outline, height: 1),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.responsive(0, 2),
                ),
                child: context.autoText(
                  '.\n.\n.',
                  style: AppFonts.headlineMedium.copyWith(
                    color: AppColorsDark.outline,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),

              _buildRankRow(
                context,
                ranks[2],
                color: AppColorsDark.onSurfaceVariant,
                isBold: true,
              ),
              const Divider(color: AppColorsDark.outline, height: 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankRow(
    BuildContext context,
    Map<String, String> rank, {
    required Color color,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.r(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.autoText(
            rank['title']!,
            style: AppFonts.labelMedium.copyWith(color: color),
          ),
          context.autoText(
            rank['level']!,
            style: AppFonts.labelSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
