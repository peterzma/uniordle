import 'package:uniordle/shared/exports/game_exports.dart';

class ReachTop extends StatelessWidget {
  const ReachTop({super.key});

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
        Text('REACH THE TOP', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: AppLayout.titleToSubtitle),
        Text(
          'Earn a new academic rank every 10 levels and reach the end. Will you be able to do it?',
          style: AppFonts.labelMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.r(16)),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.r(32)),
          child: Column(
            children: [
              _buildRankRow(context, ranks[0], color: AppColors.accent),
              const Divider(color: AppColors.outline, height: 1),

              _buildRankRow(context, ranks[1], color: AppColors.onSurface),
              const Divider(color: AppColors.outline, height: 1),

              Padding(
                padding: EdgeInsets.symmetric(vertical: context.responsive(0, 8)),
                child: Text(
                  '.\n.\n.',
                  style: AppFonts.headline.copyWith(
                    color: AppColors.outline,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              _buildRankRow(context, ranks[2], color: AppColors.onSurfaceVariant, isBold: true),
              const Divider(color: AppColors.outline, height: 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankRow(BuildContext context, Map<String, String> rank, {required Color color, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.r(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rank['title']!,
            style: AppFonts.labelMedium.copyWith(
              color: color,
            ),
          ),
          Text(
            rank['level']!,
            style: AppFonts.labelSmall.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}