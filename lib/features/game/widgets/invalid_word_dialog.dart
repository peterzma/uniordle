import 'dart:async';
import 'package:uniordle/shared/exports/game_exports.dart';

class InvalidWordDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (dialogContext) {
        
        Timer(const Duration(milliseconds: 700), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop();
          }
        });

        return BaseDialog(
          showBorder: false,
          blur: 0.0,
          padding: EdgeInsets.all(context.r(16)),
          child: context.autoText(
            'Word not found',
            textAlign: TextAlign.center,
            style: AppFonts.displayMedium,
          ),
        );
      },
    );
  }
}