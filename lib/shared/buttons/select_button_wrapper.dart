import 'package:uniordle/shared/exports/home_exports.dart';

const Duration pumpDuration = Duration(milliseconds: 100);
const Duration darkenDuration = Duration(milliseconds: 100);

/// Scale effect and Darken Effect on Click
class SelectButtonWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressScale;
  final bool enableDarken;
  final Color? baseColor;
  final double darkenIntensity;
  final BorderRadius? borderRadius;
  final SoundType soundType;

  const SelectButtonWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.pressScale = 0.98,
    this.enableDarken = false,
    this.baseColor,
    this.darkenIntensity = 0.15,
    this.borderRadius,
    this.soundType = SoundType.click,
  });

  @override
  State<SelectButtonWrapper> createState() => _PumpButtonWrapperState();
}

class _PumpButtonWrapperState extends State<SelectButtonWrapper> {
  double _scale = 1.0;
  bool _isPressed = false;
  bool _isHovered = false;

  void _updateState(double scale, bool pressed) {
    if (widget.onTap != null) {
      if (pressed) {
        SoundManager().play(widget.soundType);
      }
      setState(() {
        _scale = scale;
        _isPressed = pressed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = widget.baseColor;

    if (widget.onTap != null && widget.baseColor != null) {
      if (_isPressed && widget.enableDarken) {
        backgroundColor = Color.alphaBlend(
          Colors.black.withValues(alpha: widget.darkenIntensity),
          widget.baseColor!,
        );
      }
    }

    return MouseRegion(
      cursor: widget.onTap != null 
        ? SystemMouseCursors.click 
        : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _updateState(widget.pressScale, true),
        onTapUp: (_) => _updateState(1.0, false),
        onTapCancel: () => _updateState(1.0, false),
        child: AnimatedScale(
          scale: _isHovered && !_isPressed ? 1.02 : _scale,
          duration: pumpDuration,
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: darkenDuration,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}