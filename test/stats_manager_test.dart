// import 'package:flutter_test/flutter_test.dart';
// import 'package:uniordle/shared/exports/profile_exports.dart';

// void main() {
//   // Required for SharedPreferences mock to work
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late StatsManager manager;

//   setUp(() async {
//     // 1. Reset SharedPreferences before every test
//     SharedPreferences.setMockInitialValues({});
//     manager = StatsManager();
//     await manager.init();
//   });

//   group('StatsManager Initialization:', () {
//     test('Initializes with default values when storage is empty', () {
//       final stats = manager.statsNotifier.value;
//       expect(stats.merit, 0);
//       expect(stats.streak, 0);
//       expect(stats.solvedWords, isEmpty);
//     });
//   });

//   group('Game Recording:', () {
//     test('recordWin updates merit, streak, and solved words', () async {
//       const String testWord = 'FLUTTER';
      
//       final int gained = await manager.recordWin(
//         yearLevel: 1,
//         wordLength: 7,
//         attempts: 3,
//         maxAttempts: 6,
//         word: testWord,
//         majorId: major.id,
//       );

//       final stats = manager.statsNotifier.value;

//       expect(gained, greaterThan(0));
//       expect(stats.merit, gained);
//       expect(stats.streak, 1);
//       expect(stats.solved, 1);
//       expect(stats.solvedWords, contains(testWord.toUpperCase()));
//     });

//     test('recordLoss resets streak and applies penalty', () async {
//       // First, give the user some merit to lose
//       await manager.recordWin(
//         yearLevel: 1, wordLength: 5, attempts: 1, maxAttempts: 6, word: 'START',
//       );
      
//       final int meritBefore = manager.statsNotifier.value.merit;

//       await manager.recordLoss(
//         word: 'FAIL',
//         wordLength: 4,
//         maxAttempts: 6,
//       );

//       final stats = manager.statsNotifier.value;

//       expect(stats.streak, 0);
//       expect(stats.lost, 1);
//       expect(stats.merit, lessThan(meritBefore));
//     });
//   });

//   group('Persistence & History:', () {
//     test('Game history is capped at 50 entries', () async {
//       // Record 55 wins rapidly
//       for (int i = 0; i < 55; i++) {
//         await manager.recordWin(
//           yearLevel: 1, wordLength: 5, attempts: 1, maxAttempts: 6, word: 'WORD$i',
//         );
//       }

//       final stats = manager.statsNotifier.value;
//       expect(stats.gameHistory.length, 50);
//     });

//     test('Unlocking a major adds it to the list', () async {
//       const String majorId = 'medicine';
//       await manager.unlockMajor(majorId);
      
//       expect(manager.statsNotifier.value.unlockedIds, contains(majorId));
//     });
//   });
// }