import 'package:uniordle/shared/exports/help_exports.dart';

class LevelUp extends StatelessWidget {
  const LevelUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('LEVEL UP & UNLOCK', style: AppFonts.headline, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Guess words correctly to earn '),
              TextSpan(
                text: 'merits',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '. Level up with merits, and every five levels you unlock a new '),
              TextSpan(
                text: 'discipline',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
          style: AppFonts.labelMedium.copyWith(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
              InstructionRow(
                leading: Icon(LucideIcons.dollarSign, color: Color(0xFFFFD700), size: 24),
                color: AppColors.surfaceVariant,
                title: 'Earn Merits',
                subtitle: 'FOR EVERY CORRECT GUESS',
              ),
              const SizedBox(height: 32),
              InstructionRow(
                leading: Icon(LucideIcons.trendingUp, color: Color(0xFF4A90E2), size: 24),
                color: AppColors.surfaceVariant,
                title: 'Choose your education',
                subtitle: 'HARDER SETTINGS = MORE MERITS',
              ),
              const SizedBox(height: 32),
              InstructionRow(
                leading: Icon(LucideIcons.graduationCap, color: Color(0xFF8E99FF), size: 24),
                color: AppColors.surfaceVariant,
                title: 'Unlock Disciplines',
                subtitle: 'EVERY 5 LEVELS',
              ),
            ]
          ),
        ),
      ],
    );
  }
}