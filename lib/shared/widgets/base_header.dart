import 'package:uniordle/shared/home_screen_exports.dart'; // Adjust based on where your styles are

class BaseHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leftIcon;
  final VoidCallback onLeftTap;
  final IconData? rightIcon;
  final VoidCallback? onRightTap;

  const BaseHeader({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.onLeftTap,
    this.rightIcon,
    this.onRightTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.mainBackground.withValues(alpha: 0.8),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.backgroundBorder,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _headerIcon(
                icon: leftIcon,
                onTap: onLeftTap,
              ),
              Text(
                title,
                style: HomeFonts.titleText,
              ),
              rightIcon != null
                  ? _headerIcon(
                      icon: rightIcon!,
                      onTap: onRightTap ?? () {},
                    )
                  : const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 24,
          color: AppColors.nonSelectedIcon,
        ),
      ),
    );
  }
}