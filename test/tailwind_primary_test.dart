// Test for Tailwind.instance.primary fallback behavior.
//
// Pre-fix: when the BuildContext that was passed to .init() has been
// deactivated (e.g. the holding widget was disposed), reading .primary
// raises "Looking up a deactivated widget's ancestor is unsafe.".
// After the v1.8 fix, .primary should swallow that and fall back to
// `primaryColor ?? Colors.amber`.
//
// We deliberately leave the "wrong-init-position" case (calling init
// above MaterialApp -> fallback theme color) for documentation rather
// than runtime detection — there is no reliable way to distinguish
// "user actually wants the fallback color" from "user made the wrong
// init call" at runtime.

import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

void _resetTailwind() {
  Tailwind.instance.context = null;
  Tailwind.instance.primaryColor = null;
}

void main() {
  setUp(_resetTailwind);

  test('no init: .primary falls back to Colors.amber', () {
    expect(Tailwind.instance.primary, Colors.amber);
  });

  test('no init but primaryColor set: .primary uses primaryColor', () {
    Tailwind.instance.primaryColor = Colors.teal;
    expect(Tailwind.instance.primary, Colors.teal);
  });

  testWidgets('init inside MaterialApp: .primary returns theme primaryColor',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: Builder(builder: (ctx) {
        Tailwind.instance.init(ctx);
        return const Text('home');
      }),
    ));
    expect(Tailwind.instance.primary, Colors.red);
  });

  testWidgets(
    'init then widget tree disposed: .primary should NOT throw, should fall back',
    (tester) async {
      // phase 1: init with a context inside MaterialApp
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx, Colors.teal);
          return const Text('phase 1');
        }),
      ));
      expect(Tailwind.instance.primary, Colors.red);

      // phase 2: completely rebuild the tree → phase 1 context is deactivated
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.green),
        home: const Text('phase 2'),
      ));

      // pre-fix behavior: this throws "Looking up a deactivated widget's
      // ancestor is unsafe."
      // post-fix behavior: graceful fallback to user-provided primaryColor
      // (Colors.teal) — not Colors.green (the new theme), because the old
      // context can't reach the new MaterialApp anyway.
      expect(
        () => Tailwind.instance.primary,
        returnsNormally,
        reason: 'Accessing .primary after the holding widget is disposed '
            'must not raise — fall back instead',
      );
      expect(Tailwind.instance.primary, Colors.teal,
          reason: 'Fallback should be the primaryColor passed to init()');
    },
  );

  testWidgets(
    'init then widget tree disposed, no primaryColor: fall back to amber',
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        home: Builder(builder: (ctx) {
          Tailwind.instance.init(ctx); // no primaryColor passed
          return const Text('phase 1');
        }),
      ));

      await tester.pumpWidget(const MaterialApp(home: Text('phase 2')));

      expect(() => Tailwind.instance.primary, returnsNormally);
      expect(Tailwind.instance.primary, Colors.amber);
    },
  );
}
