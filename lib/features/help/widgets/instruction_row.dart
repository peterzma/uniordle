import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/home_exports.dart';

class InstructionRow extends StatelessWidget {
  final Widget leading;
  final Color color;
  final String title;
  final String subtitle;
  
  const InstructionRow({
    super.key,
    required this.leading,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: context.responsive(42, 48),
          height: context.responsive(42, 48),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: leading,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.autoText(
                title, 
                style: AppFonts.labelLarge,
                maxLines: 1,
                minSize: 12,
              ),
              context.autoText(
                subtitle, 
                style: AppFonts.labelMedium, 
                maxLines: 2, 
                minSize: 10
              ),
            ]
          )
        )
      ]
    );
  }
}