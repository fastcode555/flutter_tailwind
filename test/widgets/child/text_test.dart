import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('text — defaults', () {
    testWidgets("'hi'.text.mk renders a Text widget", (tester) async {
      await pumpBuilder(tester, 'hi'.text.mk);
      expect(find.text('hi'), findsOneWidget);
    });

    testWidgets('empty string still renders', (tester) async {
      await pumpBuilder(tester, ''.text.mk);
      expect(find.byType(Text), findsOneWidget);
    });
  });

  group('text — axis routing', () {
    testWidgets('color → TextStyle.color', (tester) async {
      await pumpBuilder(tester, 'hi'.text.red.mk);
      final t = tester.widget<Text>(find.byType(Text));
      expect(t.style?.color, Colors.red);
    });

    testWidgets('f16 → fontSize routed through adapter.sp (32 under 2x)', (tester) async {
      await verifyFontSizeAxis(
        tester,
        () => 'hi'.text.f16.mk,
        expected: 32,
      );
    });

    testWidgets('.bold → FontWeight.bold', (tester) async {
      await pumpBuilder(tester, 'hi'.text.bold.mk);
      final t = tester.widget<Text>(find.byType(Text));
      expect(t.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('.italic → FontStyle.italic', (tester) async {
      await pumpBuilder(tester, 'hi'.text.italic.mk);
      final t = tester.widget<Text>(find.byType(Text));
      expect(t.style?.fontStyle, FontStyle.italic);
    });

    testWidgets('.center → TextAlign.center', (tester) async {
      await pumpBuilder(tester, 'hi'.text.center.mk);
      final t = tester.widget<Text>(find.byType(Text));
      expect(t.textAlign, TextAlign.center);
    });

    testWidgets('.maxLines(2).ellipsis → maxLines + overflow set', (tester) async {
      await pumpBuilder(tester, 'long text long text long text'.text.maxLines(2).ellipsis.mk);
      final t = tester.widget<Text>(find.byType(Text));
      expect(t.maxLines, 2);
      // overflow is placed into TextStyle (not Text.overflow) by the library
      expect(t.style?.overflow, TextOverflow.ellipsis);
    });
  });

  group('text — terminators', () {
    testWidgets('.click(onTap:) wraps in a GestureDetector', (tester) async {
      var tapped = 0;
      await pumpBuilder(tester, 'hi'.text.click(onTap: () => tapped++));
      await tester.tap(find.byType(GestureDetector));
      expect(tapped, 1);
    });
  });

  group('text — regression', () {
    testWidgets('AutoSizeText under fractional adapter renders without assert', (tester) async {
      // Reproduces the v2.0.1 fix (commit f3ea926): fontSize after ssp() is
      // rounded to satisfy AutoSizeText's stepGranularity ≥ 1.0 assertion.
      Tailwind.instance.configSizeAdapter(const _FractionalAdapter());
      await pumpBuilder(tester, 'foo'.text.f30.f10.mk);
      expect(tester.takeException(), isNull);
    });
  });
}

class _FractionalAdapter implements SizeAdapter {
  const _FractionalAdapter();
  @override
  double w(double v) => v * 1.5;
  @override
  double h(double v) => v * 1.5;
  @override
  double r(double v) => v * 1.5;
  @override
  double sp(double v) => v * 1.5;
}
