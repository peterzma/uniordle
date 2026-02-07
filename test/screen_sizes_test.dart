import 'package:flutter_test/flutter_test.dart';
import 'package:uniordle/features/game_setup/views/game_setup_screen.dart';
import 'package:uniordle/shared/exports/game_exports.dart';

void main() {
  // Define a list of "Problematic" device sizes
  final Map<String, Size> devices = {
    // 'iPhone_SE_Small': const Size(320, 568),
    'My_Phone': const Size(360, 767),
    'Standard_Phone': const Size(375, 812),
    'Tall_Phone': const Size(414, 896),
    'Desktop_Breakpoint': const Size(512, 800),
    'iPad_Tablet': const Size(768, 1024),
    // 'Ultra_Narrow': const Size(280, 653), // Galaxy Fold narrow screen
  };

  group('GameSetupScreen Overflow Tests', () {
    devices.forEach((deviceName, size) {
      testWidgets('No overflow on $deviceName (${size.width}x${size.height})', (
        WidgetTester tester,
      ) async {
        await tester.binding.setSurfaceSize(size);

        await tester.pumpWidget(
          MaterialApp(home: GameSetupScreen(major: Major.mock())),
        );

        await tester.pumpAndSettle();

        expect(
          tester.takeException(),
          isNull,
          reason:
              'Overflow detected on $deviceName (${size.width}x${size.height})',
        );
      });
    });
  });
}
