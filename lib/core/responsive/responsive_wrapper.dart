import 'package:uniordle/shared/exports/core_exports.dart';
import 'package:flutter/foundation.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double dynamicWidth = AppLayout.contentWidth(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final double windowWidth = constraints.maxWidth;
        final bool mobileMode = windowWidth < AppLayout.breakpoint;

        return Material(
          color: AppColors.surface,
          child: Stack(
            children: [
              Center(
                child: OverflowBox(
                  minWidth: dynamicWidth,
                  maxWidth: dynamicWidth,
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: dynamicWidth,
                      maxWidth: dynamicWidth,
                      minHeight: AppLayout.minAppHeight,
                    ),
                    child: ClipRect(child: child),
                  ),
                ),
              ),

              if (kDebugMode)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 10,
                  child: _buildDebugBadge(windowWidth, mobileMode),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDebugBadge(double width, bool mobileMode) {
    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: mobileMode ? Colors.orange : Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${mobileMode ? "SMALL UI" : "LARGE UI"} | Screen W: ${width.toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
