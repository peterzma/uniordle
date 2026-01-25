class UserStats {
  final String streak;
  final String solved;
  final String level;

  UserStats({
    required this.streak, 
    required this.solved, 
    required this.level
  });

}

final currentStats = UserStats(streak: "12", solved: "148", level: "42"); // temporary