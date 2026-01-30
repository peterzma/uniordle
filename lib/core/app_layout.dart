import 'package:uniordle/shared/exports/game_exports.dart';

abstract class AppLayout {
  static const double breakpoint = 512.0;

  // Width constraints
  static const double minAppWidth = 360.0;
  static const double maxAppWidth = 512.0;

  // Height constraints (flexible)
  static const double minAppHeight = 640.0;
  static const double startAppHeight = 850.0;

  // Dialog constraints
  static const double maxDialogWidth = 480.0;
  static const double maxDialogHeight = 620.0;

  // Common layout constants
  static const double barHeight = 64.0;
  static const double sidePadding = 24.0;
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
  static bool isSmall(BuildContext context) => screenWidth(context) < breakpoint;

  /// Global check if we are in "Desktop" mode (exactly 512px or centered)
  static bool isLarge(BuildContext context) => screenWidth(context) >= breakpoint;

  /// Returns the width of the app content (clamped between 360 and 512)
  static double contentWidth(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    // If window is 340, it returns 360
    // If window is 400, it returns 400.
    return screenW.clamp(minAppWidth, maxAppWidth);
  }
}
