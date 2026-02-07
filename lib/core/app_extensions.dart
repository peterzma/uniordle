import 'package:uniordle/shared/exports/app_exports.dart';
import 'package:uniordle/shared/data/major_colors.dart';
import 'package:uniordle/features/game/models/letter_model.dart';

extension AppExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  Color get outline => colorScheme.outline;
  Color get surface => colorScheme.surface;
  Color get surfaceVariant => colorScheme.surfaceContainer;
  Color get onSurface => colorScheme.onSurface;
  Color get onSurfaceVariant => colorScheme.onSurfaceVariant;
  Color get dialogBackground =>
      theme.dialogTheme.backgroundColor ?? colorScheme.surface;

  GameColors get gameColors => theme.extension<GameColors>()!;

  Color getMajorColor(String id) {
    final majorExt = theme.extension<MajorColors>();
    return majorExt?.map[id] ?? colorScheme.primary;
  }

  // Use: context.getLetterBgColor(letter.status)
  Color getLetterBgColor(LetterStatus status) {
    switch (status) {
      case LetterStatus.initial:
        return surfaceVariant;
      case LetterStatus.notInWord:
        return gameColors.notInWord!;
      case LetterStatus.inWord:
        return gameColors.inWord!;
      case LetterStatus.correct:
        return gameColors.correct!;
    }
  }

  // Use: context.getLetterBorderColor(letter)
  Color getLetterBorderColor(Letter letter) {
    switch (letter.status) {
      case LetterStatus.initial:
        return letter.val.isNotEmpty ? outline : surfaceVariant;
      case LetterStatus.notInWord:
      case LetterStatus.inWord:
      case LetterStatus.correct:
        return getLetterBgColor(letter.status);
    }
  }

  Color getGradeColor(GameGrade grade) {
    switch (grade) {
      case GameGrade.fail:
        return colorScheme.error; // accent2
      case GameGrade.highDistinction:
        return colorScheme.tertiary; // accent4
      case GameGrade.distinction:
        return colorScheme.secondary; // accent3
      case GameGrade.credit:
        return colorScheme.primary; // accent
      case GameGrade.pass:
        return onSurfaceVariant; // Muted secondary text color
    }
  }

  TextStyle get displayLarge => textTheme.displayLarge ?? const TextStyle();
  TextStyle get displayMedium => textTheme.displayMedium ?? const TextStyle();
  TextStyle get headlineMedium => textTheme.headlineMedium ?? const TextStyle();
  TextStyle get labelLarge => textTheme.labelLarge ?? const TextStyle();
  TextStyle get labelMedium => textTheme.labelMedium ?? const TextStyle();
  TextStyle get labelSmall => textTheme.labelSmall ?? const TextStyle();
}
