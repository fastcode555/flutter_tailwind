import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(() {
    setUpMockAdapter();
    Debouncer.instance.resetForTest();
  });
  tearDown(() {
    tearDownAdapter();
    Debouncer.instance.resetForTest();
  });

  group('TextButton via .textButton', () {
    testWidgets('default renders TextButton with the label', (tester) async {
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () {}));
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('tap'), findsOneWidget);
    });

    testWidgets('.click() fires onTap', (tester) async {
      var tapped = 0;
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () => tapped++));
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(tapped, 1);
    });

    testWidgets('Debouncer swallows the 2nd rapid tap', (tester) async {
      var tapped = 0;
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () => tapped++));
      // Both taps in the same frame — no pump between — ensures they are within
      // the 500 ms debounce window even under wall-clock time.
      await tester.tap(find.byType(TextButton));
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(tapped, 1);
    });
  });

  group('OutlinedButton via .outlinedButton', () {
    testWidgets('default renders OutlinedButton', (tester) async {
      await pumpBuilder(tester, 'tap'.outlinedButton.click(onTap: () {}));
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('ElevatedButton via .elevatedButton', () {
    testWidgets('default renders ElevatedButton', (tester) async {
      await pumpBuilder(tester, 'tap'.elevatedButton.click(onTap: () {}));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('IconButton via iconButton', () {
    testWidgets('icon(Icons.add) renders IconButton with the icon', (tester) async {
      await pumpBuilder(tester, iconButton.icon(Icons.add).click(onTap: () {}));
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('child() then click() throws (IconButton does not support child)', (tester) async {
      expect(
        () => iconButton.icon(Icons.add).child(const Text('nope')).click(onTap: () {}),
        throwsA(isA<Exception>()),
      );
    });
  });
}
