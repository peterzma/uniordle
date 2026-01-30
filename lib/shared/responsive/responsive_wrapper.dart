import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flutter/foundation.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the actual window width for the debug logic
        final double windowWidth = constraints.maxWidth;
        final bool isSmall = windowWidth < AppLayout.breakpoint;

        return Material(
          color: AppColors.surface,
          child: Stack(
            children: [
              // 1. The App Content
              Center(
                child: OverflowBox(
                  minWidth: AppLayout.minAppWidth, // 360
                  maxWidth: AppLayout.maxAppWidth, // 512
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: AppLayout.minAppWidth,
                      maxWidth: AppLayout.maxAppWidth,
                      minHeight: AppLayout.minAppHeight,
                    ),
                    child: ClipRect(child: child),
                  ),
                ),
              ),

              // 2. The Debug Badge
              if (kDebugMode)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 10,
                  child: _buildDebugBadge(windowWidth, isSmall),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDebugBadge(double width, bool isSmall) {
    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSmall ? Colors.orange : Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${isSmall ? "SMALL UI" : "LARGE UI"} | Screen W: ${width.toInt()}',
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