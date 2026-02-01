import 'package:uniordle/shared/buttons/select_button_wrapper.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final IconData? icon;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool showShadow;
  final bool resizeLabel;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.surfaceVariant,
    this.isLoading = false,
    this.icon,
    this.height,
    this.width,
    this.borderRadius,
    this.showShadow = false,
    this.resizeLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height ?? context.r(64);
    final double effectiveRadius = borderRadius ?? effectiveHeight / 2;
    
    return SelectButtonWrapper(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width, 
        height: effectiveHeight,
        padding: width == null 
            ? EdgeInsets.symmetric(horizontal: context.r(64)) 
            : null,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(effectiveRadius),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: context.r(20),
                    offset: Offset(0, context.r(10)),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: isLoading 
            ? _buildLoader(context) 
            : _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return SizedBox(
      height: context.r(24),
      width: context.r(24),
      child: const CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, 
      children: [
        if (icon != null) ...[
          Icon(icon, size: context.r(28), color: Colors.white),
          SizedBox(width: context.r(8)),
        ],
        resizeLabel 
          ? context.autoText(
              label.toUpperCase(),
              style: AppFonts.labelLarge,
              minSize: 14,
              maxSize: 18,
            )
          : Text(
              label.toUpperCase(),
              style: AppFonts.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
      ],
    );
  }
}