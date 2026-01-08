import 'package:flutter/material.dart';

enum GameStatus { playing, submitting, won, lost }

class WordleScreen extends StatefulWidget {
  const WordleScreen({Key? key}) : super(key: key);

  @override
  _WordleScreenState createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'WORDLE',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        )
      ),
    );
  }
}