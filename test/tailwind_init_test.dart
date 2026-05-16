import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

void _resetTailwind() {
  Tailwind.instance.screenW = 0.0;
  Tailwind.instance.screenH = 0.0;
  Tailwind.instance.primaryColor = null;
  Tailwind.instance.sizeAdapter = const IdentitySizeAdapter();
}

void main() {
  setUp(_resetTailwind);

  group('primary color fallback', () {
    test('no init: .primary returns Colors.amber', () {
      expect(Tailwind.instance.primary, Colors.amber);
    });

    test('primaryColor set directly: .primary returns that color', () {
      Tailwind.instance.primaryColor = Colors.teal;
      expect(Tailwind.instance.primary, Colors.teal);
    });
  });

  group('init() caches screen dimensions', () {
    testWidgets('init populates screenW/screenH from MediaQuery', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx);
          return const Text('home');
        }),
      ));
      expect(Tailwind.instance.screenW, greaterThan(0));
      expect(Tailwind.instance.screenH, greaterThan(0));
    });

    testWidgets('init populates primaryColor from Theme', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx);
          return const Text('home');
        }),
      ));
      expect(Tailwind.instance.primary, Colors.red);
    });

    testWidgets('init with fallbackPrimary overrides Theme value', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx, Colors.purple);
          return const Text('home');
        }),
      ));
      expect(Tailwind.instance.primary, Colors.purple);
    });
  });

  group('hFull/wFull require init', () {
    testWidgets('without init: container.hFull asserts in debug', (tester) async {
      // The assert in _screenH should fire when accessed without init.
      expect(
        () => container.hFull.red.mk,
        throwsA(isA<AssertionError>().having(
          (e) => e.toString(),
          'message',
          contains('init(context)'),
        )),
        reason: 'Should fail with a message pointing at init(context)',
      );
    });

    testWidgets('with init: container.hFull renders successfully', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx);
          return Container(
            color: Colors.white,
            child: container.hFull.red.child(const SizedBox()),
          );
        }),
      ));
      final c = tester.widget<Container>(find.byType(Container).last);
      expect(c.constraints?.maxHeight, Tailwind.instance.screenH);
    });
  });
}
