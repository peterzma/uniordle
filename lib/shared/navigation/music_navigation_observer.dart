import 'package:uniordle/shared/exports/game_setup_exports.dart';

class MusicNavigationObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _handleMusic(previousRoute?.settings.name);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _handleMusic(route.settings.name);
  }

  void _handleMusic(String? routeName) {
    switch (routeName) {
      case '/':
      case '/setup':
      case '/settings':
        SoundManager().playMusic(SoundType.menuMusic);
        break;
      case '/uniordle':
        SoundManager().playMusic(SoundType.gameMusic);
        break;
    }
  }
}