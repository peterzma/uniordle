import 'package:flutter/material.dart';
import 'package:uniordle/shared/layout/base_dialog.dart';


Future<T?> baseShowDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  Color barrierColor = Colors.transparent,
  Duration transitionDuration = Duration.zero,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    barrierColor: barrierColor,
    transitionDuration: transitionDuration,
    pageBuilder: (context, anim1, anim2) => BaseDialog(
      child: child,
    ),
  );
}