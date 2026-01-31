import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class UnlockedMajorDialog extends StatelessWidget {
  final Major major;

  const UnlockedMajorDialog({super.key, required this.major});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppLayout.maxDialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.responsive(60, 80),
            height: context.responsive(60, 80),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              IconMapper.getIcon(major.icon),
              color: major.color,
              size: context.r(60),
            ),
          ),
          SizedBox(height: context.r(8)),
          context.autoText(
            "CONGRATULATIONS",
            style: AppFonts.displayMedium.copyWith(color: major.color),
            reduction: 8,
          ),
          SizedBox(height: context.r(16)),
          context.autoText(
            "You have officially enrolled in the ${major.name} Department.",
            textAlign: TextAlign.center,
            style: AppFonts.labelLarge,
            maxLines: 2,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            onPressed: () => Navigator.pop(context),
            label: "START STUDYING",
            color: major.color,
          ),
        ],
      ),
    );
  }
}