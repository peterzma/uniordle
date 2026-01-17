import 'package:uniordle/shared/game_setup_exports.dart';

class AppTextStyles {
  static const String displayFont = 'Lexend';
  static const String uiFont = 'PlusJakartaSans';

  // Display Styles
  static TextStyle get gameTitle => const TextStyle(
        fontFamily: displayFont,
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Colors.white,
  );

  static TextStyle get tileNumber => const TextStyle(
        fontFamily: displayFont,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: Colors.white,
    );

  // UI Styles
  static TextStyle get buttonText => const TextStyle(
        fontFamily: uiFont,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
  );

  static TextStyle get smallLabel => const TextStyle(
        fontFamily: uiFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        letterSpacing: 1.1,
  );

  static TextStyle get microData => const TextStyle(
        fontFamily: uiFont,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Colors.blueAccent,
  );
}

class GameFonts {  
  static TextStyle get tileText => AppTextStyles.tileNumber;

  static TextStyle get keyText => AppTextStyles.tileNumber.copyWith(fontSize: 24);

  static TextStyle get infoBarText => AppTextStyles.microData.copyWith(color: Colors.white, fontWeight: FontWeight.w600);
}

class GameSetUpFonts {
  static TextStyle get yearLevelText => AppTextStyles.gameTitle.copyWith(fontSize: 20, letterSpacing: 1.2);
  
  static TextStyle attemptsAllowedText(Color color) => AppTextStyles.smallLabel.copyWith(color: color, fontWeight: FontWeight.bold, letterSpacing: 1.5);

  static TextStyle get yearLabelBase => AppTextStyles.smallLabel.copyWith(fontWeight: FontWeight.normal, color: Colors.white54);

  static TextStyle get yearLabelActive => AppTextStyles.smallLabel.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

  static TextStyle get attemptsInactiveText => AppTextStyles.smallLabel.copyWith(fontWeight: FontWeight.normal, color: Colors.white54);

  static TextStyle attemptsActiveText(Color color) => AppTextStyles.smallLabel.copyWith(fontWeight: FontWeight.bold, color: color);

  static const IconData attemptsIcon = Icons.favorite;

  static TextStyle get closeButtonText => AppTextStyles.buttonText.copyWith(color: Colors.blueGrey);

  static TextStyle gameSettingsText(Color color) => AppTextStyles.smallLabel.copyWith(color: color, fontWeight: FontWeight.bold, letterSpacing: 2);

  static TextStyle get playGameText => AppTextStyles.buttonText.copyWith(color: AppColors.mainBackground, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.1);

  static TextStyle get wordLengthText => AppTextStyles.gameTitle.copyWith(fontSize: 20, letterSpacing: 1.2);

  static TextStyle get numberOfLettersText => AppTextStyles.tileNumber;

  static TextStyle get lettersText => AppTextStyles.smallLabel;

  static TextStyle get disciplineText => AppTextStyles.gameTitle.copyWith(fontSize: 32);
}

class HomeFonts {
  static TextStyle get disciplineText => AppTextStyles.buttonText.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle get titleText => AppTextStyles.gameTitle;

  static TextStyle get mainHeroText => AppTextStyles.gameTitle.copyWith(fontSize: 40, letterSpacing: -1, fontWeight: FontWeight.w900);

  static TextStyle get subHeroText => AppTextStyles.smallLabel.copyWith(fontSize: 14, color: Colors.blueGrey, height: 1.5);

  static TextStyle iconText(Color color) => AppTextStyles.microData.copyWith(letterSpacing: 1.4, color: color);

  static TextStyle tagText(Color color) => AppTextStyles.microData.copyWith(color: color);
}