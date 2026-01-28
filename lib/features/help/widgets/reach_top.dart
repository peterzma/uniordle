import 'package:uniordle/shared/exports/game_exports.dart';

class ReachTop extends StatelessWidget {
  const ReachTop({super.key});

  final List<Map<String, String>> ranks = const [
    {'title': 'UNDERGRADUATE', 'level': 'LEVEL 0+'},
    {'title': 'BACHELOR', 'level': 'LEVEL 10+'},
    {'title': '???', 'level': 'LEVEL 70+'}, // CHANCELLOR
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
        const SizedBox(height: 24),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildRankRow(ranks[0], color: AppColors.accent),
              const Divider(color: AppColors.outline, height: 1),

              _buildRankRow(ranks[1], color: AppColors.onSurface),
              const Divider(color: AppColors.outline, height: 1),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '.\n.\n.',
                  style: AppFonts.headline.copyWith(
                    color: AppColors.outline,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              _buildRankRow(ranks[2], color: AppColors.onSurfaceVariant, isBold: true),
              const Divider(color: AppColors.outline, height: 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankRow(Map<String, String> rank, {required Color color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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