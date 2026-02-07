import 'package:uniordle/shared/exports/app_exports.dart';

abstract class AppColorsDark {
  // Game Logic
  static const Color correctColor = Color(0xFF4caf50); // Success / Correct
  static const Color inWordColor = Color(0XFFEAD637); // Warning / In Word
  static const Color notInWordColor = Color(0xFF475569); // Wrong / Not in Word

  // Backgrounds
  static const Color surface = Color(0xFF00121f); // Main background
  static const Color surfaceDialog = Color(0xFF060C16); // Only for dialog boxs
  static const Color surfaceVariant = Color(
    0xFF001a2c,
  ); // Cards,keyboard buttons

  // Content (Text/Icons)
  static const Color onSurface = Color(0xFFF8FAFC); // High emphasis text
  static const Color onSurfaceVariant = Color(
    0xFF94A3B8,
  ); // Medium emphasis / secondary text / inactive
  static const Color outline = Color(0xFF334155);

  // UI Accents
  static const Color accent = Color(
    0xFF3B82F6,
  ); // Active icons/selection / Basic
  static const Color accent2 = Color(0xFFEF4444); // Negative / Loss etc
  static const Color accent3 = Color(
    0xFFF4D35E,
  ); // Good, Merits / Positive (End Game Completionist)
  static const Color accent4 = Color(0xFFF18F01); // Very good / Best (Ranks)

  // Major Specific Colors
  static const Color majorEngineering = Color(0xFF4DD0E1); // Muted Cyan
  static const Color majorCS = Color(0xFF7986CB); // Dusty Blue
  static const Color majorMedicine = Color(0xFFF06292); // Soft Rose
  static const Color majorLaw = Color(0xFFFFB74D); // Pastel Orange
  static const Color majorPsychology = Color(0xFFBA68C8); // Soft Lavender
  static const Color majorArts = Color(0xFFE57373); // Muted Coral
  static const Color majorHumanities = Color(0xFFFFF176); // Soft Sand
  static const Color majorEducation = Color(0xFF81D4FA); // Baby Blue
  static const Color majorMaths = Color(0xFF9575CD); // Deep Petal
  static const Color majorMusic = Color(0xFFDCE775); // Pear Green
  static const Color majorArchitecture = Color(0xFF4DB6AC); // Sage Teal
  static const Color majorNursing = Color(0xFFFF8A65); // Peach
  static const Color majorHistory = Color(0xFFA1887F); // Taupe
  static const Color majorJournalism = Color(0xFF90A4AE); // Blue Grey
  static const Color majorAstronomy = Color(0xFF7986CB); // Twilight Blue
  static const Color majorPhilosophy = Color(0xFFCFD8DC); // Slate White
  static const Color majorPhysics = Color(0xFFB39DDB); // Pale Violet
  static const Color majorChemistry = Color(0xFF81C784); // Soft Mint
  static const Color majorBiology = Color(0xFFAED581); // Moss Green
  static const Color majorEconomics = Color(0xFF66BB6A); // Soft Emerald
}
