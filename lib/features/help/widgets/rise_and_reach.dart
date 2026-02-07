import 'package:uniordle/shared/exports/help_exports.dart';

class RiseAndReach extends StatelessWidget {
  const RiseAndReach({super.key});

  final List<Map<String, String>> ranks = const [
    {'title': 'UNDERGRADUATE', 'level': 'LEVEL 0+'},
    {'title': 'BACHELOR', 'level': 'LEVEL 10+'},
    {'title': '???', 'level': 'LEVEL ???'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.autoText(
          'RISE & REACH',
          style: context.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(8)),
        context.autoText(
          'Climb the academic ranks every 10 levels and unlock new titles to become ???',
          style: context.labelMedium,
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

              SizedBox(height: context.responsive(12, 16)),
              Divider(color: context.colorScheme.outline, height: 1),
              SizedBox(height: context.responsive(12, 16)),

              _buildRankRow(
                context,
                ranks[1],
                color: context.colorScheme.onSurface,
              ),

              SizedBox(height: context.responsive(12, 16)),
              Divider(color: context.colorScheme.outline, height: 1),
              SizedBox(height: context.responsive(12, 16)),

              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.responsive(0, 2),
                ),
                child: context.autoText(
                  '.\n.\n.',
                  style: context.headlineMedium.copyWith(
                    color: context.colorScheme.outline,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
              ),

              SizedBox(height: context.responsive(12, 16)),

              _buildRankRow(
                context,
                ranks[2],
                color: context.colorScheme.onSurfaceVariant,
                isBold: true,
              ),

              SizedBox(height: context.responsive(12, 16)),
              Divider(color: context.colorScheme.outline, height: 1),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        context.autoText(
          rank['title']!,
          style: context.labelMedium.copyWith(color: color),
        ),
        context.autoText(
          rank['level']!,
          style: context.labelSmall.copyWith(color: color),
        ),
      ],
    );
  }
}
