import 'package:uniordle/shared/exports/settings_exports.dart';

class AboutGameDialog extends StatelessWidget {
  const AboutGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAppIcon(context),
          SizedBox(height: context.r(32)),
          context.autoText("Uniordle", style: AppFonts.displayLarge),
          SizedBox(height: context.r(16)),
          context.autoText("Made by Peter", style: AppFonts.labelLarge),
          SizedBox(height: context.r(8)),
          context.autoText(
            "Software Engineering Student @ UQ",
            style: AppFonts.labelMedium,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            onPressed: () => showLicensePage(context: context),
            label: "LICENSES",
            color: AppColorsDark.accent,
          ),
          SizedBox(height: context.r(16)),
          PrimaryButton(
            onPressed: () => Navigator.pop(context),
            label: "CLOSE",
          ),
        ],
      ),
    );
  }

  Widget _buildAppIcon(BuildContext context) => CircleAvatar(
    radius: context.r(60),
    backgroundColor: context.surfaceVariant,
    child: Image.asset(
      'assets/images/white_on_blue/favicon.png',
      fit: BoxFit.contain,
    ),
  );
}
