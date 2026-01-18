import 'package:uniordle/shared/exports/home_screen_exports.dart';
import 'package:uniordle/shared/navigation/app_nav_item.dart';
import 'package:uniordle/shared/layout/base_footer.dart';


class HomeFooter extends StatelessWidget implements PreferredSizeWidget {
  final String activeTab;
  final ValueChanged<String> onTabChange;
  
  const HomeFooter({
    super.key, 
    required this.activeTab, 
    required this.onTabChange
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build (BuildContext context) {
    return BaseFooter(
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppNavItem(
                icon: LucideIcons.history,
                label: 'Stats',
                isActive: activeTab == 'stats',
                onTap: () => onTabChange('stats'),
              ),
              AppNavItem(
                icon: LucideIcons.layoutGrid,
                label: 'Home',
                isActive: activeTab == 'home',
                onTap: () => onTabChange('home'),
              ),
              AppNavItem(
                icon: LucideIcons.user,
                label: 'Profile',
                isActive: activeTab == 'profile',
                onTap: () => onTabChange('profile'),
              ),
            ],
        ),
      ),
    );
  }
}