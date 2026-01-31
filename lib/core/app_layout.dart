import 'package:auto_size_text/auto_size_text.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

abstract class AppLayout {
  static const double breakpoint = 512.0;

  // Width constraints
  static const double minAppWidth = 360.0;
  static const double maxAppWidth = 512.0;

  // Height constraints (flexible)
  static const double minAppHeight = 640.0;
  static const double startAppHeight = 767.0;

  // Dialog constraints
  static const double maxDialogWidth = 480.0;
  static const double maxDialogHeight = 620.0;
  
// --- Base Scale Units ---
  static const double size3XL = 64.0; 
  static const double size2XL = 32.0; 
  static const double sizeXL  = 24.0; 
  static const double sizeL   = 16.0; 
  static const double sizeM   = 12.0; 
  static const double sizeS   = 8.0;  
  static const double sizeXS  = 4.0;  
  static const double sizeXXS = 2.0;

  // Common layout constants
  static const double marginHeight = 64.0; // header/footers
  static const double pagePadding = 16.0; // not fully used
  static const double cardPadding = 16.0;
  static const double cardRounding = 16.0; // not fully used
  static const double dialogPadding = 32.0;
  static const double dialogRounding = 16.0; // unused
  static const double settingsPadding = 16;

  static const double settingsTileHeight = 60.0;
  static const int flipSpeedMs = 300;
  static const double dialogIcon = 64.0;
  static const double titleToSubtitle = 8.0;
  static const double gapBetweenButtons = 16.0;
  static const double gapToButton = 32.0;
  static const double badgeToContent = 16.0;

  /// Returns the actual width of the window
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// Returns the actual height of the window
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  /// Global check if we are in "Mobile" mode (under 512px)
  static bool mobileMode(BuildContext context) => screenWidth(context) < breakpoint;

  /// Global check if we are in "Desktop" mode (exactly 512px or centered)
  static bool desktopMode(BuildContext context) => screenWidth(context) >= breakpoint;

  /// Returns the width of the app content (clamped between 360 and 512)
  static double contentWidth(BuildContext context) {
    // If window is 340, it returns 360
    // If window is 400, it returns 400.
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
}

extension ResponsiveLayout on BuildContext {
  /// Shorthand for AppLayout.lerp: context.responsive(16, 32)
  double responsive(double min, double max) => AppLayout.lerp(this, min, max);

  /// Automatically scales any number by 50% on the smallest mobile width.
  /// Usage: context.r(32) -> returns 16 on mobile, 32 on desktop.
  double r(double value) => AppLayout.lerp(this, value / 2, value);
  
  Widget autoText(
    String text, {
    required TextStyle style,
    double? minSize, 
    double? maxSize,
    double reduction = 2,
    int maxLines = 1,
    TextAlign textAlign = TextAlign.center,
  }) {
    final double effectiveMax = maxSize ?? style.fontSize ?? 14;
    
    final double effectiveMin = minSize ?? (effectiveMax - reduction);

    return AutoSizeText(
      text,
      textAlign: textAlign,
      style: style.copyWith(
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
    return Icon(
      icon,
      color: color,
      size: responsive(size - reduction, size),
    );
  }

  Widget autoRichText(
    List<InlineSpan> children, {
    required TextStyle style,
    double? minSize,
    double? maxSize,
    double reduction = 2,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
  }) {
    final double effectiveMax = maxSize ?? style.fontSize ?? 14;
    final double effectiveMin = minSize ?? (effectiveMax - reduction);

    final double currentFontSize = responsive(effectiveMin, effectiveMax);

    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
      text: TextSpan(
        children: children,
        style: style.copyWith(fontSize: currentFontSize),
      ),
    );
  }
}
