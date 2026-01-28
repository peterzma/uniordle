import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/help_exports.dart';

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(AppIcons.thankYou, size: 64, color: Colors.orange),
          const SizedBox(height: 16),
          Text("COMMENCEMENT", style: AppFonts.headline),
          const SizedBox(height: 12),
          Text(
            "Congratulations, Graduate! You've reached the highest rank in Uniordle. Your dedication is truly academic. (Thank you so much for playing! - Creator)",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'The pleasure was mine',
            color: Colors.orange,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}