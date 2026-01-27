// import 'package:uniordle/shared/exports/end_game_exports.dart';

// class LevelUpDialog extends StatefulWidget {
//   final int startingLevel;
//   final double startingProgress;
//   final double gainedXP;
//   final VoidCallback onContinue;

//   const LevelUpDialog({
//     super.key,
//     required this.startingLevel,
//     required this.startingProgress,
//     required this.gainedXP,
//     required this.onContinue,
//   });

//   @override
//   State<LevelUpDialog> createState() => _LevelUpDialogState();
// }

// class _LevelUpDialogState extends State<LevelUpDialog> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _hasLeveledUp = false;
//   int _newLevelReached = 0;

//   @override
//   void initState() {
//     super.initState();
//     final double startTotal = widget.startingLevel + widget.startingProgress;
//     final double levelGain = widget.gainedXP / 100;
//     final double endTotal = startTotal + levelGain;

//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500 + (levelGain * 500).toInt()),
//     );

//     _animation = Tween<double>(begin: startTotal, end: endTotal)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));

//     _controller.addListener(() {
//       int currentLevel = _animation.value.floor();
//       if (currentLevel > widget.startingLevel && !_hasLeveledUp) {
//         setState(() {
//           _hasLeveledUp = true;
//           _newLevelReached = currentLevel;
//         });
//       }
//     });

//     Future.delayed(const Duration(milliseconds: 400), () => _controller.forward());
//   }

//   String _getRankMessage(int level) {
//     if (level % 10 == 0) return "NEW ACADEMIC RANK!";
//     if (level % 5 == 0 && level <= 70) return "ACADEMIC MILESTONE!";
//     return "LEVEL UP!";
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//   } 
// }



