import 'package:uniordle/shared/exports/game_exports.dart';
import 'package:flutter/foundation.dart'; // Required for kDebugMode

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < AppLayout.breakpoint;

        return Material(
          color: AppColors.surface,
          child: Stack(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isSmall ? double.infinity : AppLayout.minAppWidth,
                  ),
                  child: ClipRect(child: child),
                ),
              ),

              if (kDebugMode)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  right: 10,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSmall ? Colors.orange : Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isSmall ? 'SMALL (${constraints.maxWidth.toInt()})' : 'LARGE (${constraints.maxWidth.toInt()})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}