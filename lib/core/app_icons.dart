import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

abstract class AppIcons {
  // UI Menu
  static const IconData leftArrow = LucideIcons.chevronLeft;
  static const IconData rightArrow = LucideIcons.chevronRight;
  static const IconData help = LucideIcons.helpCircle;
  static const IconData settings = LucideIcons.settings;
  
  // Settings
  static const IconData volume = Icons.volume_up_rounded;
  static const IconData volumeOff = Icons.volume_off;
  static const IconData linkedIn = Icons.person_search_rounded;
  static const IconData gitHub = Icons.code_rounded;
  static const IconData bugReport = Icons.bug_report_rounded;
  static const IconData feedback = Icons.lightbulb_outline_rounded;
  static const IconData about = Icons.info_outline_rounded;
  static const IconData deleteData = Icons.delete_forever_rounded;
  static const IconData inProgressDeleteData1 = Icons.warning_amber_rounded;
  static const IconData inProgressDeleteData2 = Icons.error_outline_rounded; 
  static const IconData settingsRightArrow = Icons.chevron_right;
  static const IconData backgroundMusic = Icons.music_note;
  static const IconData backgroundMusicMuted = Icons.music_off;

  // Gameplay
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData attempts = Icons.favorite;
  static const IconData backspace = Icons.backspace;
  static const IconData gameWin = Icons.stars_rounded;
  static const IconData gameLoss = Icons.close_rounded;
  static const IconData merits = Icons.stars;
  static const IconData credits = Icons.payments;
  static const IconData abandonGame = Icons.warning_amber_rounded;

  // Profile
  static const IconData defaultProfile = Icons.account_circle;
  static const IconData streak = Icons.local_fire_department;
  static const IconData solved = Icons.check_circle_outline;
  static const IconData unlockedRank = Icons.check_circle;
  static const IconData nextRank = Icons.radio_button_checked;
  static const IconData lockedRank = Icons.lock_outline;
  static const IconData finalRank = LucideIcons.crown;
  static const IconData thankYou = Icons.auto_stories;
  static const IconData mastered = Icons.workspace_premium;
  static const IconData completionist = LucideIcons.crown;
  static const IconData ascension = LucideIcons.trophy;
}

class IconMapper {
  static IconData getIcon(String name) {
    switch (name) {
      case 'lock': return Icons.lock_outline;
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