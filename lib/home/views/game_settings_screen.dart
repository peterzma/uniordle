import 'package:flutter/material.dart';
import 'package:uniordle/app/app_colors.dart';
import 'package:uniordle/home/models/discipline.dart';
import 'package:uniordle/home/widgets/game_settings/header.dart';

class GameSettingsScreen extends StatefulWidget {
  final Discipline discipline;

  const GameSettingsScreen({
    super.key,
    required this.discipline,
  });

  @override
  State<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends State<GameSettingsScreen> {
  int _wordLength = 5;
  int _difficulty = 1;
  bool _isLoading = false;

  void _play() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);
    // go to uniordle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeScreenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Column(
            children: [
            SettingsHeader(
              discipline: widget.discipline,
            ),
            ]
          )
        )
      )
    );
  }
}