import 'package:uniordle/shared/exports/profile_screen_exports.dart';

class ProfileHeader extends StatelessWidget {
  final Color primaryColor, bgColor;
  const ProfileHeader({super.key, required this.primaryColor, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 30),
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.account_circle, size: 84, color: Colors.red),
                  ),
                ),
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: bgColor, width: 3),
                  ),
                  child: const Icon(
                    Icons.check, 
                    size: 14, 
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Temp Name", 
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              "Academic Level: ", 
              ),
              Text(
                "SENIOR", 
              ),
            ],
          ),
        ],
      ),
    );
  }
}