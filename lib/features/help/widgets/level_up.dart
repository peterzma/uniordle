import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class LevelUp extends StatelessWidget {
  const LevelUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('LEVEL UP & UNLOCK', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: AppLayout.titleToSubtitle),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Guess words correctly to earn '),
                TextSpan(
                  text: 'merits',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: '. Level up with merits, and gain a '),
                TextSpan(
                  text: 'credit ',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: 'every five levels.'),
              ],
            ),
            style: AppFonts.labelMedium.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            children: [
              InstructionRow(
                leading: Icon(LucideIcons.dollarSign, color: Colors.amberAccent, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Earn Merits',
                subtitle: 'FOR EVERY CORRECT GUESS',
              ),
              const SizedBox(height: 32),
              InstructionRow(
                leading: Icon(LucideIcons.trendingUp, color: Colors.green, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Customise',
                subtitle: 'HARDER SETTINGS = MORE MERITS',
              ),
              const SizedBox(height: 32),
              InstructionRow(
                leading: Icon(LucideIcons.graduationCap, color: AppColors.accent, size: 24),
                color: AppColors.surfaceVariant,
                title: 'Use Credits',
                subtitle: 'UNLOCK NEW DISCIPLINES',
              ),
            ]
          ),
        ),
      ],
    );
  }
}