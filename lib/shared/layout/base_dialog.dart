import 'dart:ui';
import 'package:uniordle/shared/exports/game_exports.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final double blur;
  final Widget? leftAction;
  final Widget? rightAction;
  final EdgeInsets? padding;
  final EdgeInsets? insetPadding;
  final bool showBorder;

  const BaseDialog({
    super.key,
    required this.child,
    this.blur = 4.0,
    this.leftAction,
    this.rightAction,
    this.padding,
    this.insetPadding,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Dialog(
            elevation: 0,
            backgroundColor: AppColors.surfaceDialog, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppLayout.maxDialogWidth,
              ),
              child: Padding(
                padding: padding ?? EdgeInsets.all(context.responsive(24, AppLayout.dialogPadding)),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [child],
              ),
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