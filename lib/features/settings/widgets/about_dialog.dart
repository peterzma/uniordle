import 'package:uniordle/shared/exports/settings_exports.dart';

class AboutDialog extends StatelessWidget {
  const AboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppIcon(),
            const SizedBox(height: 24),
            Text("Uniordle", style: AppFonts.displayLarge),
            const SizedBox(height: 12),
            _buildAuthorText(),
            const SizedBox(height: 24),
            Text(
              "Software Engineering Student @ UQ", 
              style: AppFonts.labelMedium.copyWith(color: AppColors.accent)
            ),
            const SizedBox(height: 36),
            PrimaryButton(
              onPressed: () => showLicensePage(context: context),
              label: "LICENSES",
              color: AppColors.accent,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              onPressed: () => Navigator.pop(context),
              label: "CLOSE",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon() => Container(
    height: 80, width: 80,
    decoration: BoxDecoration(
      color: AppColors.accent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Icon(Icons.school, size: 40, color: Colors.white),
  );

  Widget _buildAuthorText() => RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: AppFonts.displayMedium,
      children: [
        const TextSpan(text: "A solo project by "),
        TextSpan(
          text: "Peter",
          style: AppFonts.displayMedium.copyWith(
            fontWeight: FontWeight.bold, 
            color: AppColors.inWordColor
          ),
        ),
      ],
    ),
  );
}