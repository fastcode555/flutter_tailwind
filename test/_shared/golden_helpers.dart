import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'adapter_helpers.dart';

bool _fontsLoaded = false;

/// Loads the default Roboto font from the package's test-resources so golden
/// renders are reproducible across macOS dev / Linux CI. Idempotent.
///
/// Task 20 drops Roboto-Regular.ttf and Roboto-Bold.ttf under
/// test/widgets_golden/fonts/ and wires them into pubspec.yaml assets. Until
/// then this function's font load will silently no-op (the FlutterError catch
/// below absorbs the missing-asset case), and golden tests fall back to the
/// system font — fine for compile-time wiring, but visual snapshots won't be
/// pixel-stable across machines.
Future<void> loadAppFonts() async {
  if (_fontsLoaded) return;
  TestWidgetsFlutterBinding.ensureInitialized();
  final fontLoader = FontLoader('Roboto');
  for (final asset in ['Roboto-Regular.ttf', 'Roboto-Bold.ttf']) {
    final path = 'packages/flutter_tailwind/test/widgets_golden/fonts/$asset';
    try {
      fontLoader.addFont(rootBundle.load(path));
    } on FlutterError {
      // Font asset missing — golden tests will fall back to system font.
    }
  }
  await fontLoader.load();
  _fontsLoaded = true;
}

/// Pumps `widget` (with mock adapter installed — caller is responsible for
/// installing it via setUpMockAdapter) and matches against
/// `goldens/<name>.png` next to the test file.
Future<void> goldenTest(
  WidgetTester tester,
  Widget widget,
  String name,
) async {
  await pumpBuilder(tester, widget);
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$name.png'),
  );
}

/// Boxes `widget` in a fixed-size container so golden snapshots are crop-
/// stable. Use when the widget under test would otherwise expand to fill.
Widget boxed(Widget child, {double w = 200, double h = 200}) {
  return Center(
    child: SizedBox(width: w, height: h, child: child),
  );
}
