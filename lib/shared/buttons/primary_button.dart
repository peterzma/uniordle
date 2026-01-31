import 'package:uniordle/shared/buttons/select_button_wrapper.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool isLoading;
  final IconData? icon;
  final double? height; // Changed to nullable to allow responsive defaults
  final double? width;
  final double? borderRadius;
  final bool showShadow;

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
  });

  @override
  Widget build(BuildContext context) {
    // Typical Button Ratios: Height ~56, Width ~300 (scales down to ~28, ~150 on tiny screens)
    final double effectiveHeight = height ?? context.r(56);
    final double effectiveWidth = width ?? context.r(300);
    final double effectiveRadius = borderRadius ?? effectiveHeight / 2;

    return SelectButtonWrapper(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: effectiveWidth,
        height: effectiveHeight,
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
      children: [
        if (icon != null) ...[
          Icon(icon, size: context.r(28), color: Colors.white),
          SizedBox(width: context.r(8)),
        ],
        // Using autoText so long labels don't break the button on 360px screens
        context.autoText(
          label.toUpperCase(),
          style: AppFonts.labelLarge,
          minSize: 12,
          maxSize: 18,
        ),
      ],
    );
  }
}