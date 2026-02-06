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
  static const IconData gameRepeat = Icons.refresh;
  static const IconData gameMeritRange = LucideIcons.arrowRight;
  static const IconData gameBoostedMerit = LucideIcons.trendingUp;

  // Progression & Badges
  // Level 100
  static const IconData badgeOracle = LucideIcons.crown; 
  // The "I solved everything" reward
  static const IconData badgeMastery = LucideIcons.trophy; 
  static const IconData badgeResearch = LucideIcons.microscope;
  static const IconData statStreak = Icons.local_fire_department;
  static const IconData statSolved = Icons.check_circle_outline;
  static const IconData statMastered = Icons.auto_stories;
  static const IconData statRank = Icons.workspace_premium;
  static const IconData statLossPenalty = LucideIcons.trendingDown;
  static const IconData statAbandonCost = LucideIcons.ghost;
  static const IconData firstEnrollment = LucideIcons.bookOpen;
  static const IconData permanentMeritBonus = LucideIcons.trendingUp;

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

  // Major Specific Icons
  static const IconData majorEngineering = LucideIcons.settings;
  static const IconData majorCS = LucideIcons.code;
  static const IconData majorMedicine = LucideIcons.heartPulse;
  static const IconData majorLaw = LucideIcons.scale;
  static const IconData majorPsychology = LucideIcons.brain;
  static const IconData majorArts = LucideIcons.palette;
  static const IconData majorBusiness = LucideIcons.briefcase;
  static const IconData majorHumanities = LucideIcons.bookOpen;
  static const IconData majorEducation = LucideIcons.graduationCap;
  static const IconData majorMaths = LucideIcons.calculator;
  static const IconData majorMusic = LucideIcons.music;
  static const IconData majorScience = LucideIcons.flaskConical;
  static const IconData majorDesign = LucideIcons.penTool;
  static const IconData majorArchitecture = LucideIcons.building2;
  static const IconData majorNursing = LucideIcons.stethoscope;
  static const IconData majorHistory = LucideIcons.landmark;
  static const IconData majorAgriculture = LucideIcons.sprout;
  static const IconData majorJournalism = LucideIcons.newspaper;
  static const IconData majorAstronomy = LucideIcons.star;
  static const IconData majorPhilosophy = LucideIcons.scroll;
}