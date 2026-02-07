import 'package:uniordle/shared/exports/core_exports.dart';

class Major {
  final String id;
  final String name;
  final IconData icon;
  final bool isLocked;
  final int totalWords;

  Major({
    required this.id,
    required this.name,
    required this.icon,
    required this.totalWords,
    this.isLocked = true,
  });

  /// Mock data for testing and previews
  factory Major.mock() {
    return Major(
      id: 'cs_101',
      name: 'Computer Science',
      icon: Icons.laptop,
      totalWords: 150,
      isLocked: false,
    );
  }

  /// Handy for state management or testing different UI states
  Major copyWith({String? name, Color? color, bool? isLocked}) {
    return Major(
      id: id,
      name: name ?? this.name,
      icon: icon,
      totalWords: totalWords,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
