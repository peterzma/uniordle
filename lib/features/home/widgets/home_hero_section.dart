import 'package:uniordle/shared/exports/home_screen_exports.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build (BuildContext context) {
    return Column(
      children: [
        Text(
          'Select a Discipline',
          style: AppFonts.displayLarge,
        ),
        SizedBox(height: 8),
        Text(
          'Master your academic vocabulary.',
          textAlign: TextAlign.center,
          style: AppFonts.labelMedium,
        ),
      ],
    );
  }
}