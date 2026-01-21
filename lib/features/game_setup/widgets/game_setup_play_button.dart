import 'package:uniordle/features/home/models/discipline.dart';
import 'package:uniordle/shared/exports/game_setup_exports.dart';
import 'package:uniordle/shared/buttons/select_button_wrapper.dart';

class PlayButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Discipline discipline;

  const PlayButton({
    super.key, 
    required this.isLoading, 
    required this.onPressed,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return PumpButtonWrapper(
      onTap: isLoading ? null : onPressed,
      pressScale: 0.97,
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: discipline.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.black,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 32, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'PLAY GAME',
                      style: GameSetUpFonts.playGameText,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}