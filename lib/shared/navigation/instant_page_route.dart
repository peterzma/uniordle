import 'package:uniordle/shared/exports/app_exports.dart';

class InstantPageRoute extends PageRouteBuilder {
  final Widget page;

  InstantPageRoute({
    required this.page, super.settings
  }): super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
    );
}