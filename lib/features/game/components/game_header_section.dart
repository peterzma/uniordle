import 'package:uniordle/shared/game_screen_exports.dart';

class GameHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  const GameHeader({
    super.key,
    this.onBack,
    this.onSettings,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainBackground,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: onBack ?? () => Navigator.maybePop(context),
                ),
              ),
              const Text(
                'Uniordle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'clashdisplay',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: onSettings ?? () {},
                ),
              ),
            ]
          )
        )
      )
    );
  }
}