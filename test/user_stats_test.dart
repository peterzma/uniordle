import 'package:flutter_test/flutter_test.dart';
import 'package:uniordle/shared/exports/profile_exports.dart';

void main() {
  group('UserStats Mastery Logic:', () {
    test('Mastered count identifies fully solved majors', () {
      // Assuming 'engineering' has 3 words: ['GEAR', 'BOLT', 'IRON']
      // User has solved all three
      final stats = UserStats(
        streak: 0,
        solved: 3,
        merit: 0,
        solvedWords: ['GEAR', 'BOLT', 'IRON'],
      );

      expect(stats.masteredCount, 1);
      expect(stats.getMajorProgress('engineering', 3).percent, 1.0);
    });

    test('Mastered majors provide 50% merit reduction', () {
      final stats = UserStats(
        streak: 0,
        solved: 3,
        merit: 0,
        solvedWords: ['GEAR', 'BOLT', 'IRON'], // Engineering is mastered
      );

      // Merit for an UNMASTERED major
      final fullMerit = UserStatsRewards.generateGainedMerit(
        stats: stats,
        yearLevel: 1,
        wordLength: 5,
        attempts: 1,
        majorId: 'cs', 
      );

      // Merit for a MASTERED major
      final reducedMerit = UserStatsRewards.generateGainedMerit(
        stats: stats,
        yearLevel: 1,
        wordLength: 5,
        attempts: 1,
        majorId: 'engineering',
      );

      // Should be exactly 50% (allowing for rounding)
      expect(reducedMerit, closeTo(fullMerit / 2, 1.0));
    });
  });
}