import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('container — defaults', () {
    // When no size/padding/margin/alignment is set, ContainerBuilder.mk returns a
    // DecoratedBox (not a Container). Adding s100 forces the Container path.
    testWidgets('container.s100.mk renders a Container', (tester) async {
      await pumpBuilder(tester, container.s100.mk);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('container.s100.child(widget) wraps the given child', (tester) async {
      await pumpBuilder(tester, container.s100.child(const Text('hi')));
      expect(find.text('hi'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });

  group('container — axis routing', () {
    testWidgets('color → BoxDecoration.color', (tester) async {
      await verifyColorAxis(
        tester,
        () => container.red.s100.mk,
        expectedColor: Colors.red,
      );
    });

    // s100 uses `size=100` → container.dart calls sr(size!) → 200 under 2x.
    // Flutter Container stores width/height as BoxConstraints.tightFor, so
    // constraints.maxWidth == constraints.minWidth == 200.
    testWidgets('s100 → width/height through adapter.r (200/200 under 2x)', (tester) async {
      await pumpBuilder(tester, container.s100.mk);
      final c = tester.widget<Container>(find.byType(Container));
      expect(c.constraints?.maxWidth, 200);
      expect(c.constraints?.maxHeight, 200);
    });

    // ContainerBuilder stores padding via Container.padding (not a Padding widget),
    // so read it directly from the Container rather than via verifyPaddingAxis.
    testWidgets('p16 → padding through adapter.r (32 under 2x)', (tester) async {
      await pumpBuilder(tester, container.p16.child(const SizedBox()));
      final c = tester.widget<Container>(find.byType(Container));
      expect(c.padding, const EdgeInsets.all(32));
    });

    testWidgets('m16 → margin through adapter.r', (tester) async {
      await verifyMarginAxis(
        tester,
        () => container.m16.red.s100.mk,
        expected: const EdgeInsets.all(32),
      );
    });

    testWidgets('rounded8 → BorderRadius.circular(16) under 2x', (tester) async {
      await verifyBorderRadiusAxis(
        tester,
        () => container.red.rounded8.s100.mk,
        expectedRadius: 16,
      );
    });

    // Border widths are NOT routed through the adapter — they are stored as-is.
    testWidgets('border2 → border width 2 (not adapter-scaled)', (tester) async {
      await verifyBorderWidthAxis(
        tester,
        () => container.red.border2.borderBlack.s100.mk,
        expectedWidth: 2,
      );
    });

    testWidgets('borderBlack → border color black', (tester) async {
      await verifyBorderColorAxis(
        tester,
        () => container.red.border2.borderBlack.s100.mk,
        expectedColor: Colors.black,
      );
    });

    // shadowSm is a preset with exactly 1 BoxShadow.
    testWidgets('shadowSm → at least one BoxShadow', (tester) async {
      await verifyShadowAxis(
        tester,
        () => container.red.shadowSm.s100.mk,
        expectedCount: 1,
      );
    });

    testWidgets('center → Container.alignment = Alignment.center', (tester) async {
      await verifyAlignmentAxis(
        tester,
        () => container.center.s100.child(const Text('x')),
        expected: Alignment.center,
      );
    });
  });

  group('container — terminators', () {
    testWidgets('.mk returns a Container with no child', (tester) async {
      await pumpBuilder(tester, container.red.s100.mk);
      final c = tester.widget<Container>(find.byType(Container));
      expect(c.child, isNull);
    });

    testWidgets('.child(w) returns a Container with that child', (tester) async {
      const marker = ValueKey('marker');
      await pumpBuilder(tester, container.s100.child(const SizedBox(key: marker)));
      expect(find.byKey(marker), findsOneWidget);
    });
  });
}
