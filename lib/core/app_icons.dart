import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

abstract class AppIcons {
  // Navigation & UI
  static const IconData navBack = LucideIcons.chevronLeft;
  static const IconData navForward = LucideIcons.chevronRight;
  static const IconData navSettings = LucideIcons.settings;
  static const IconData navHelp = LucideIcons.helpCircle;

  // Gameplay
  static const IconData gameMerit = Icons.stars;
  static const IconData gameCredit = Icons.payments;
  static const IconData gamePlay = Icons.play_arrow_rounded;
  static const IconData gameWin = Icons.stars_rounded;
  static const IconData gameLoss = Icons.close_rounded;
  static const IconData gameAttempts = Icons.favorite;
  static const IconData gameAbandon = Icons.warning_amber_rounded;
  static const IconData gameBackspace = Icons.backspace;

  // Progression & Badges
  // Level 100
  static const IconData badgeOracle = LucideIcons.crown; 
  // The "I solved everything" reward
  static const IconData badgeMastery = LucideIcons.trophy; 
  static const IconData statStreak = Icons.local_fire_department;
  static const IconData statSolved = Icons.check_circle_outline;
  static const IconData statMastered = Icons.auto_stories;
  static const IconData statRank = Icons.workspace_premium;

  // Profile UI
  static const IconData profileDefault = Icons.account_circle;
  static const IconData profileLock = Icons.lock_outline;
  static const IconData profileUnlock = Icons.check_circle;
  static const IconData profileNext = Icons.radio_button_checked;
  
  // System & Settings
  static const IconData sysVolumeOn = Icons.volume_up_rounded;
  static const IconData sysVolumeOff = Icons.volume_off;
  static const IconData sysMusicOn = Icons.music_note;
  static const IconData sysMusicOff = Icons.music_off;
  static const IconData sysDelete = Icons.delete_forever_rounded;
  static const IconData sysConfirmDelete = Icons.delete_forever_rounded;
  static const IconData inProgressDeleteData1 = Icons.warning_amber_rounded;
  static const IconData inProgressDeleteData2 = Icons.error_outline_rounded; 

  // Links
  static const IconData linkSource = Icons.code_rounded;
  static const IconData linkProfile = Icons.person_search_rounded;
  static const IconData linkBug = Icons.bug_report_rounded;
  static const IconData linkIdea = Icons.lightbulb_outline_rounded;
  static const IconData linkInfo = Icons.info_outline_rounded;
  static const IconData linkAbout = Icons.info_outline_rounded;

  // Settings
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