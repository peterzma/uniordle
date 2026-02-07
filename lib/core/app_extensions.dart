import 'package:uniordle/shared/exports/app_exports.dart';

extension ThemeHelper on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
