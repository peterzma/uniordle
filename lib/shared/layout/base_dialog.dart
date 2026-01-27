import 'dart:ui';
import 'package:uniordle/core/app_layout.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final double blur;
  final Widget? leftAction;
  final Widget? rightAction;

  const BaseDialog({
    super.key,
    required this.child,
    this.blur = 10.0,
    this.leftAction,
    this.rightAction,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppLayout.maxDialogWidth),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
          ),
          
          if (leftAction != null)
            Positioned(
              left: 40, 
              child: leftAction!,
            ),
          if (rightAction != null)
            Positioned(
              right: 40, 
              child: rightAction!,
            ),
        ],
      ),
    );
  }
}