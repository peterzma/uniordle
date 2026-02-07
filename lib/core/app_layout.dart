import 'package:uniordle/shared/exports/app_exports.dart';

abstract class AppLayout {
  // Screen
  static const double breakpoint = 512.0;

  // Width constraints
  static const double minAppWidth = 360.0;
  static const double maxAppWidth = 512.0;

  // Height constraints (flexible)
  static const double minAppHeight = 640.0;
  static const double startAppHeight = 767.0;

  // Common layout constants
  static const double marginHeight = 64.0; // header/footers
  static const double dialogPadding = 32.0;
  static const double settingsPadding = 16.0;
  static const double cardRounding = 16.0;
  static const double pagePadding = 16.0;
  static const double cardPadding = 16.0; // stats

  // Game
  static const int flipSpeedMs = 300;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Check if we are in "Mobile" mode
  static bool mobileMode(BuildContext context) =>
      screenWidth(context) < breakpoint;

  /// Check if we are in "Desktop" mode (exactly 512px or centered)
  static bool desktopMode(BuildContext context) =>
      screenWidth(context) >= breakpoint;

  /// Returns the width of the app content (clamped between 360 and 512)
  static double contentWidth(BuildContext context) {
    return screenWidth(context).clamp(minAppWidth, maxAppWidth);
  }

  /// Returns a factor between 0.0 (at 360px) and 1.0 (at 512px)
  static double scaleFactor(BuildContext context) {
    final double width = contentWidth(context);
    return (width - minAppWidth) / (maxAppWidth - minAppWidth);
  }

  /// Internal logic for scaling values
  static double lerp(BuildContext context, double min, double max) {
    return min + (max - min) * scaleFactor(context);
  }

  static double verticalScaleFactor(BuildContext context) {
    final double height = screenHeight(context);
    if (height <= minAppHeight) return 0.0;
    if (height >= startAppHeight) return 1.0;
    return (height - minAppHeight) / (startAppHeight - minAppHeight);
  }

  static double lerpHeight(BuildContext context, double min, double max) {
    return min + (max - min) * verticalScaleFactor(context);
  }
}

extension ResponsiveLayout on BuildContext {
  /// Shorthand for AppLayout.lerp: context.responsive(16, 32)
  double responsive(double min, double max) => AppLayout.lerp(this, min, max);

  /// Automatically scales any number by 50% on the smallest mobile width.
  /// Usage: context.r(32) -> returns 16 on mobile, 32 on desktop.
  double r(double value) => AppLayout.lerp(this, value / 2, value);

  /// Scales based on height, capped at my 767px sweet spot.
  /// Usage: context.v(16, 64) -> won't exceed 64 even on a giant screen.
  double v(double min, double max) => AppLayout.lerpHeight(this, min, max);

  Widget autoText(
    String text, {
    TextStyle? style,
    double? minSize,
    double? maxSize,
    double reduction = 2,
    int maxLines = 1,
    TextAlign textAlign = TextAlign.center,
  }) {
    final TextStyle effectiveStyle = style ?? const TextStyle();

    final double effectiveMax = maxSize ?? effectiveStyle.fontSize ?? 14;
    final double effectiveMin = minSize ?? (effectiveMax - reduction);

    return AutoSizeText(
      text,
      textAlign: textAlign,
      style: effectiveStyle.copyWith(
        fontSize: responsive(effectiveMin, effectiveMax),
      ),
      minFontSize: effectiveMin,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget autoIcon(
    IconData icon, {
    double size = 24,
    double reduction = 4,
    Color? color,
  }) {
    return Icon(icon, color: color, size: responsive(size - reduction, size));
  }
}
