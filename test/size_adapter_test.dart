import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reusable test double: every value is doubled.
class Mock2xAdapter implements SizeAdapter {
  const Mock2xAdapter();
  @override
  double w(double v) => v * 2;
  @override
  double h(double v) => v * 2;
  @override
  double r(double v) => v * 2;
  @override
  double sp(double v) => v * 2;
}

void resetAdapter() {
  Tailwind.instance.sizeAdapter = const IdentitySizeAdapter();
}

void main() {
  group('IdentitySizeAdapter', () {
    const adapter = IdentitySizeAdapter();

    test('w() returns input unchanged', () {
      expect(adapter.w(16.0), 16.0);
      expect(adapter.w(0.0), 0.0);
    });

    test('h() returns input unchanged', () {
      expect(adapter.h(100.0), 100.0);
    });

    test('r() returns input unchanged', () {
      expect(adapter.r(8.5), 8.5);
    });

    test('sp() returns input unchanged', () {
      expect(adapter.sp(14.0), 14.0);
    });
  });

  group('Container threads geometry through adapter', () {
    setUp(resetAdapter);

    testWidgets('width uses adapter.w', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.w200.red.child(const SizedBox()),
      ));
      final c = tester.widget<Container>(find.byType(Container).first);
      expect(c.constraints?.maxWidth, 400.0);
    });

    testWidgets('height uses adapter.h', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.h100.red.child(const SizedBox()),
      ));
      final c = tester.widget<Container>(find.byType(Container).first);
      expect(c.constraints?.maxHeight, 200.0);
    });

    testWidgets('size uses adapter.r', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.s50.red.child(const SizedBox()),
      ));
      final c = tester.widget<Container>(find.byType(Container).first);
      expect(c.constraints?.maxWidth, 100.0);
      expect(c.constraints?.maxHeight, 100.0);
    });
  });

  group('PaddingBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('container.p16 doubles padding under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.red.p16.child(const SizedBox()),
      ));
      final c = tester.widget<Container>(find.byType(Container).first);
      expect(c.padding, const EdgeInsets.all(32.0));
    });
  });

  group('MarginBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('container.m16 doubles margin under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.red.m16.child(const SizedBox()),
      ));
      final c = tester.widget<Container>(find.byType(Container).first);
      expect(c.margin, const EdgeInsets.all(32.0));
    });
  });

  group('BorderRadiusBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('container.rounded8 doubles radius under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.red.rounded8.child(const SizedBox()),
      ));
      final db = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final deco = db.decoration as BoxDecoration;
      final br = deco.borderRadius as BorderRadius;
      expect(br.topLeft.x, 16.0);
    });
  });

  group('PositionedBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('positioned.l16.t8 doubles offsets under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: Stack(children: [
          positioned.l16.t8.child(const SizedBox()),
        ]),
      ));
      final p = tester.widget<Positioned>(find.byType(Positioned).first);
      expect(p.left, 32.0);
      expect(p.top, 16.0);
    });
  });

  group('ShadowBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('container.shadow doubles blur/offset under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: container.red.shadowSm.child(const SizedBox()),
      ));
      final db = tester.widget<DecoratedBox>(find.byType(DecoratedBox).first);
      final deco = db.decoration as BoxDecoration;
      final shadow = deco.boxShadow!.first;
      expect(shadow.blurRadius, 4.0); // shadowSm base blurRadius=2.0, doubled=4.0
    });
  });

  group('SpacingBuilder threads through adapter.r', () {
    setUp(resetAdapter);
    testWidgets('column.spacing16 doubles gap under mock', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: column.spacing16.children([
          const Text('a'),
          const Text('b'),
        ]),
      ));
      // The library uses SizedBox separators between children
      // SizedBox height should be 32.0 (16 * 2)
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      final spacer = sizedBoxes.firstWhere(
        (sb) => sb.height == 32.0,
        orElse: () => throw TestFailure('No SizedBox with height 32.0 found'),
      );
      expect(spacer.height, 32.0);
    });
  });

  group('FontSizeBuilder threads through adapter.sp', () {
    setUp(resetAdapter);
    testWidgets("'hello'.text.f16 doubles fontSize under mock", (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(
        home: 'hello'.text.f16.bold.mk,
      ));
      final t = tester.widget<Text>(find.text('hello'));
      expect(t.style?.fontSize, 32.0);
    });
  });

  group('Other geometry builders thread through adapter', () {
    setUp(resetAdapter);

    testWidgets('SizedBox.s50 doubles', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(home: sizedBox.s50.mk));
      final sb = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sb.width, 100.0);
      expect(sb.height, 100.0);
    });

    testWidgets('Icon.s24 doubles', (tester) async {
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(home: Icons.add.icon.s24.mk));
      final i = tester.widget<Icon>(find.byType(Icon).first);
      expect(i.size, 48.0);
    });
  });

  group('adapter swap behavior', () {
    setUp(resetAdapter);

    testWidgets('switching adapter mid-test affects subsequent mk calls', (tester) async {
      // First adapter — identity (default)
      await tester.pumpWidget(MaterialApp(home: container.w100.red.child(const SizedBox())));
      final c1 = tester.widget<Container>(find.byType(Container).first);
      expect(c1.constraints?.maxWidth, 100.0);

      // Swap to 2x
      Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
      await tester.pumpWidget(MaterialApp(home: container.w100.red.child(const SizedBox())));
      final c2 = tester.widget<Container>(find.byType(Container).first);
      expect(c2.constraints?.maxWidth, 200.0);

      // Swap back
      Tailwind.instance.configSizeAdapter(const IdentitySizeAdapter());
      await tester.pumpWidget(MaterialApp(home: container.w100.red.child(const SizedBox())));
      final c3 = tester.widget<Container>(find.byType(Container).first);
      expect(c3.constraints?.maxWidth, 100.0);
    });
  });
}
