import 'package:uniordle/core/app_icons.dart';
import 'package:uniordle/shared/exports/end_game_exports.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';
import 'package:uniordle/shared/layout/base_show_dialog.dart';

class DataResetService {
  static Future<void> showDialog(BuildContext context) async {
    final bool? firstConfirm = await baseShowDialog<bool>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(AppIcons.inProgressDeleteData1, size: AppLayout.dialogIcon, color: AppColors.accent2),
          SizedBox(height: context.r(8)),
          Text("RESET PROGRESS?", style: AppFonts.headline),
          const SizedBox(height: AppLayout.titleToSubtitle),
          Text(
            "This will permanently delete your level, stats, and academic rank.",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'RESET EVERYTHING',
            color: Colors.red,
            onPressed: () => Navigator.pop(context, true),
          ),
          SizedBox(height: context.r(8)),
          PrimaryButton(
            label: 'CANCEL',
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );

    if (firstConfirm != true) return;
    if (!context.mounted) return;

    final bool? secondConfirm = await baseShowDialog<bool>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(AppIcons.inProgressDeleteData2, size: AppLayout.dialogIcon, color: AppColors.accent2),
          SizedBox(height: context.r(8)),
          Text("ARE YOU CERTAIN?", style: AppFonts.headline),
          const SizedBox(height: AppLayout.titleToSubtitle),
          Text(
            "There is no way to recover your data once deleted. Be very careful!",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'I AM SURE',
            color: Colors.red,
            onPressed: () => Navigator.pop(context, true),
          ),
          SizedBox(height: context.r(8)),
          PrimaryButton(
            label: 'NEVERMIND',
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );

    if (secondConfirm == true) {
      if (!context.mounted) return;
      await _performReset(context);
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
              style: AppFonts.labelLarge.copyWith(color: AppColors.onSurface),
            ),
          ),
          backgroundColor: AppColors.accent2,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}