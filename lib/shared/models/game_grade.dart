import 'package:uniordle/shared/exports/core_exports.dart';

enum GameGrade {
  highDistinction("HIGH DISTINCTION"),
  distinction("DISTINCTION"),
  credit("CREDIT"),
  pass("PASS"),
  fail("FAIL");

  final String label;
  const GameGrade(this.label);

  factory GameGrade.calculate(bool won, int attempts, int maxAttempts) {
    if (!won) return GameGrade.fail;

    final double weight =
        (maxAttempts - attempts) / (maxAttempts - 1).toDouble();

    if (weight >= 0.80) return GameGrade.highDistinction;
    if (weight >= 0.60) return GameGrade.distinction;
    if (weight >= 0.40) return GameGrade.credit;
    return GameGrade.pass;
  }

  Color get color {
    switch (this) {
      case GameGrade.fail:
        return context.colorScheme.error;
      case GameGrade.highDistinction:
        return AppColorsDark.accent4;
      case GameGrade.distinction:
        return AppColorsDark.accent3;
      case GameGrade.credit:
        return AppColorsDark.accent;
      case GameGrade.pass:
        return AppColorsDark.onSurfaceVariant;
    }
  }
}
