import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

/// Verifies InputConfig resolution: per-instance ?? global config ?? fallback.
void main() {
  // InputConfig lives on the Tailwind singleton; reset between tests so global
  // state never leaks.
  tearDown(() => Tailwind.instance.inputConfig = const InputConfig());

  Future<InputDecoration> pumpAndReadDecoration(
    WidgetTester tester,
    Widget input,
  ) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: input)));
    await tester.pump();
    return tester.widget<TextField>(find.byType(TextField)).decoration!;
  }

  group('global InputConfig is applied to a bare Input', () {
    testWidgets('fillColor/filled/border/contentPadding/hintStyle/constraints',
        (tester) async {
      const fill = Color(0xFF112233);
      const border = OutlineInputBorder();
      const padding = EdgeInsets.all(7);
      const hint = TextStyle(fontSize: 13);
      const suffixC = BoxConstraints(minWidth: 44);
      Tailwind.instance.configInput(const InputConfig(
        fillColor: fill,
        border: border,
        contentPadding: padding,
        hintStyle: hint,
        suffixIconConstraints: suffixC,
      ));

      final d = await pumpAndReadDecoration(
          tester, const Input(hintText: 'x'));

      // fillColor: unfocused resolves to effUnFocus ?? effFill == fill.
      expect(d.fillColor, fill);
      expect(d.filled, isTrue);
      expect(d.border, isA<OutlineInputBorder>());
      expect(d.enabledBorder, isA<OutlineInputBorder>());
      expect(d.contentPadding, padding);
      expect(d.hintStyle, hint);
      expect(d.suffixIconConstraints, suffixC);
    });
  });

  group('per-instance value wins over global config', () {
    testWidgets('instance fillColor overrides config fillColor',
        (tester) async {
      Tailwind.instance.configInput(const InputConfig(
        fillColor: Color(0xFF112233),
      ));

      const instanceFill = Color(0xFFAABBCC);
      final d = await pumpAndReadDecoration(
          tester, const Input(fillColor: instanceFill));

      expect(d.fillColor, instanceFill);
      expect(d.filled, isTrue);
    });
  });

  group('no config: behavior unchanged (backward compatible)', () {
    testWidgets('bare Input is not filled and has no fill color',
        (tester) async {
      final d = await pumpAndReadDecoration(
          tester, const Input(hintText: 'x'));

      expect(d.filled, isFalse);
      expect(d.fillColor, isNull);
    });

    testWidgets('suffixIconConstraints falls back to minWidth:30',
        (tester) async {
      final d = await pumpAndReadDecoration(
          tester, const Input(hintText: 'x'));

      expect(d.suffixIconConstraints, const BoxConstraints(minWidth: 30));
    });
  });
}
