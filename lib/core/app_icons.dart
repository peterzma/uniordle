import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

abstract class AppIcons {
  static const IconData leftArrow = LucideIcons.chevronLeft;
  static const IconData rightArrow = LucideIcons.chevronRight;
  static const IconData help = LucideIcons.helpCircle;
  
  static const IconData volume = Icons.volume_up_rounded;
  static const IconData attempts = Icons.favorite;
  static const IconData linkedIn = Icons.person_search_rounded;
  static const IconData gitHub = Icons.code_rounded;
  static const IconData bugReport = Icons.bug_report_rounded;
  static const IconData feedback = Icons.lightbulb_outline_rounded;
  static const IconData about = Icons.info_outline_rounded;
  static const IconData deleteData = Icons.delete_forever_rounded;
  static const IconData backspace = Icons.backspace;
  static const IconData gameWin = Icons.stars_rounded;
  static const IconData gameLoss = Icons.close_rounded;
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData merits = Icons.stars;
  static const IconData settingsRightArrow = Icons.chevron_right;
}

class IconMapper {
  static IconData getIcon(String name) {
    switch (name) {
      case 'settings': return LucideIcons.settings;
      case 'code': return LucideIcons.code;
      case 'heart_pulse': return LucideIcons.heartPulse;
      case 'scale': return LucideIcons.scale;
      case 'brain': return LucideIcons.brain;
      case 'palette': return LucideIcons.palette;
      case 'briefcase': return LucideIcons.briefcase;
      case 'book_open': return LucideIcons.bookOpen;
      case 'graduation_cap': return LucideIcons.graduationCap;
      case 'calculator': return LucideIcons.calculator;
      case 'music': return LucideIcons.music;
      case 'flask_conical': return LucideIcons.flaskConical;
      case 'pen_tool': return LucideIcons.penTool;
      case 'building_2': return LucideIcons.building2;
      default: return LucideIcons.bookOpen;
    }
  }
}