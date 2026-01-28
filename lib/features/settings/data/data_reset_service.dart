import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/settings_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataResetService {
  static Future<void> showResetDialog(BuildContext context) async {
    final bool? firstConfirm = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: Duration.zero,
      pageBuilder: (context, anim1, anim2) => BaseDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(AppIcons.inProgressDeleteData1, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text("RESET PROGRESS?", style: AppFonts.headline),
            const SizedBox(height: 12),
            Text(
              "This will permanently delete your level, stats, and academic rank. You will start back at Level 0.",
              style: AppFonts.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'YES, RESET EVERYTHING',
              color: Colors.red,
              onPressed: () => Navigator.pop(context, true),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'CANCEL',
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );

    if (firstConfirm == true) {
      if (!context.mounted) return;

      final bool? secondConfirm = await showGeneralDialog<bool>(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration.zero,
        pageBuilder: (context, anim1, anim2) => BaseDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(AppIcons.inProgressDeleteData2, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text("ARE YOU CERTAIN?", style: AppFonts.headline),
              const SizedBox(height: 12),
              Text(
                "There is no way to recover your data once deleted. This is your last chance to turn back.",
                style: AppFonts.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'I AM SURE, DELETE IT ALL',
                color: Colors.red,
                onPressed: () => Navigator.pop(context, true),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'NEVERMIND',
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ),
      );

      if (secondConfirm == true) {
        if (!context.mounted) return;
        await _performReset(context);
      }
    }
  }

  static Future<void> _performReset(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            heightFactor: 1,
            child: Text(
              'Data wiped. Restart app to finalise.',
              style: AppFonts.labelLarge.copyWith(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}