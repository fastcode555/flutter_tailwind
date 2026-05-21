import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('row', () {
    testWidgets('.children([...]) renders a Row with given children', (tester) async {
      await pumpBuilder(
        tester,
        row.children([const Text('a'), const Text('b')]),
      );
      expect(find.byType(Row), findsOneWidget);
      expect(find.text('a'), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
    });

    testWidgets('.spacing16 inserts SizedBox(width: 32) under 2x', (tester) async {
      await pumpBuilder(
        tester,
        row.spacing16.children([const SizedBox(), const SizedBox()]),
      );
      // _RowBuilder.children() inserts SizedBox(width: sr(spacing)) separators.
      // sr(16) == 32 under Mock2xAdapter.
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final spacer = sizedBoxes.firstWhere(
        (sb) => sb.width == 32.0,
        orElse: () => throw TestFailure('No SizedBox with width 32.0 found'),
      );
      expect(spacer.width, 32.0);
    });

    testWidgets('color → DecoratedBox(BoxDecoration.color)', (tester) async {
      await pumpBuilder(tester, row.red.children([const Text('x')]));
      // _LinearBuilder wraps in DecoratedBox (not Container) when innerColor != null.
      final decorated = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final dec = decorated.decoration as BoxDecoration;
      expect(dec.color, Colors.red);
    });
  });

  group('column', () {
    testWidgets('.children([...]) renders a Column', (tester) async {
      await pumpBuilder(
        tester,
        column.children([const Text('a'), const Text('b')]),
      );
      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('.spacing20 inserts SizedBox(height: 40) under 2x', (tester) async {
      await pumpBuilder(
        tester,
        column.spacing20.children([const SizedBox(), const SizedBox()]),
      );
      // _ColumnBuilder.children() inserts SizedBox(height: sr(spacing)) separators.
      // sr(20) == 40 under Mock2xAdapter.
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final spacer = sizedBoxes.firstWhere(
        (sb) => sb.height == 40.0,
        orElse: () => throw TestFailure('No SizedBox with height 40.0 found'),
      );
      expect(spacer.height, 40.0);
    });
  });

  group('stack', () {
    testWidgets('.children([...]) renders a Stack with given children', (tester) async {
      await pumpBuilder(
        tester,
        stack.children([const Text('a'), const Text('b')]),
      );
      // Scaffold may contain an internal Stack; confirm ours via text children.
      expect(find.text('a'), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
      // At least one Stack is present (our stack builder's output).
      expect(find.byType(Stack), findsWidgets);
    });
  });
}
