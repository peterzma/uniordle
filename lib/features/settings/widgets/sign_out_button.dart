import 'package:uniordle/shared/exports/settings_exports.dart';

class SettingsSignOutButton extends StatelessWidget {
  final VoidCallback onTap;

  const SettingsSignOutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Material(
        color: Colors.transparent, // Set to transparent so the border/outline style works
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.red.withValues(alpha: 0.2),
          highlightColor: Colors.red.withValues(alpha: 0.1),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Sign Out',
              textAlign: TextAlign.center,
              style: AppFonts.labelMedium.copyWith(color: Colors.red)
            ),
          ),
        ),
      ),
    );
  }
}