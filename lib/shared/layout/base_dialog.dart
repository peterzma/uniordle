import 'dart:ui';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final double blur;

  const BaseDialog({
    super.key,
    required this.child,
    this.blur = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppLayout.maxDialogWidth), 
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}