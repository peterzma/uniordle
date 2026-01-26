import 'package:uniordle/shared/exports/home_screen_exports.dart';

class InstructionRow extends StatelessWidget {
  final String letter;
  final Color color;
  final String title;
  final String subtitle;
  
  const InstructionRow({
    super.key,
    required this.letter,
    required this.color,
    required this.title,
    required this.subtitle,
  });
  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 10),
              )
            ]
          ),
          alignment: Alignment.center,
          child: Text(
            letter,
            style: AppFonts.displayMedium
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFonts.labelLarge,
                ),
              Text(
                subtitle,
                style: AppFonts.labelMedium
              ),
            ]
          )
        )
      ]
    );
  }
}