import 'package:uniordle/shared/exports/help_exports.dart';

class ReachTop extends StatelessWidget {
  const ReachTop({super.key});

  final List<Map<String, String>> ranks = const [
    {'title': 'UNDERGRADUATE', 'level': 'LEVEL 0-9'},
    {'title': 'BACHELOR', 'level': 'LEVEL 10-19'},
    {'title': 'HONOURS', 'level': 'LEVEL 20-29'},
    {'title': 'MASTERS', 'level': 'LEVEL 30-39'},
    {'title': 'DOCTORAL', 'level': 'LEVEL 40-49'},
    {'title': 'PROFESSOR', 'level': 'LEVEL 50-59'},
    {'title': 'DEAN', 'level': 'LEVEL 60+'},
    {'title': '???', 'level': 'LEVEL 70+'}, // CHANCELLOR
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('REACH THE TOP', style: AppFonts.headline, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              'Earn a new academic rank every 10 levels!',
              style: AppFonts.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 220,
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: ranks.map((rank) {
                      bool isSecret = rank['title'] == '???';
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  rank['title']!,
                                  style: AppFonts.labelMedium.copyWith(
                                    color: isSecret ? AppColors.accent : AppColors.onSurface,
                                  ),
                                ),
                                Text(
                                  rank['level']!,
                                  style: AppFonts.labelSmall.copyWith(
                                    color: isSecret ? AppColors.accent : AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: AppColors.outline, height: 1),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}