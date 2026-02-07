import 'package:uniordle/shared/exports/settings_exports.dart';

class DataResetService {
  static Future<void> showDialog(BuildContext context) async {
    final bool? firstConfirm = await showBaseDialog<bool>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.inProgressDeleteData1,
            size: context.r(64),
            color: AppColors.accent2,
          ),
          SizedBox(height: context.r(8)),
          Text("RESET PROGRESS?", style: AppFonts.headlineMedium),
          SizedBox(height: context.r(8)),
          Text(
            "This will permanently delete your level, stats, and academic rank.",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'YES, RESET EVERYTHING',
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

    final bool? secondConfirm = await showBaseDialog<bool>(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.inProgressDeleteData2,
            size: context.r(64),
            color: AppColors.accent2,
          ),
          SizedBox(height: context.r(8)),
          Text("ARE YOU CERTAIN?", style: AppFonts.headlineMedium),
          SizedBox(height: context.r(8)),
          Text(
            "There is no way to recover your data once deleted. Be very careful!",
            style: AppFonts.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.r(32)),
          PrimaryButton(
            label: 'I AM SURE, RESET EVERYTHING',
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

    await statsManager.reinitialize();

    if (context.mounted) {
      Phoenix.rebirth(context);
    }
  }
}
