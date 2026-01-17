import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/game_setup_exports.dart';

class SettingsFooter extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPlay;
  final VoidCallback onClose;
  final Discipline discipline;

  const SettingsFooter({
    super.key,
    required this.isLoading,
    required this.onPlay,
    required this.onClose,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: bottomPadding > 0 ? bottomPadding : 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlayButton(isLoading: isLoading, onPressed: onPlay, discipline: discipline),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}