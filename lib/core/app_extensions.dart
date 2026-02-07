import 'package:uniordle/shared/exports/app_exports.dart';

extension ThemeHelper on BuildContext {
  // Use: context.theme
  ThemeData get theme => Theme.of(this);

  // Use: context.textTheme.displayLarge
  TextTheme get textTheme => theme.textTheme;

  // Use: context.colorScheme.primary
  ColorScheme get colorScheme => theme.colorScheme;

  // Use: context.dialogBackground
  Color get dialogBackground =>
      theme.dialogTheme.backgroundColor ?? colorScheme.surface;

  // Use: context.gameColors.correct
  GameColors get gameColors => theme.extension<GameColors>()!;

  // Use: context.outline
  Color get outline => colorScheme.outline;

  // Use: context.surfaceVariant
  Color get surfaceVariant => colorScheme.surfaceContainer;

  // Use: context.onSurface
  Color get onSurface => colorScheme.onSurface;

  // Use: context.onSurfaceVariant
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;
}
