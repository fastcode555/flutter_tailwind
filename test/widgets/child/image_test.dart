import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('ImageLoader — 4 constructors render', () {
    testWidgets('.image(url) renders without throwing', (tester) async {
      await pumpBuilder(
        tester,
        ImageLoader.image('https://example.com/x.jpg', width: 100, height: 100),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('.circle(url, radius:50) renders without throwing', (tester) async {
      await pumpBuilder(
        tester,
        ImageLoader.circle('https://example.com/x.jpg', radius: 50),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('.round(url, borderRadius:...) renders without throwing', (tester) async {
      await pumpBuilder(
        tester,
        ImageLoader.round(
          'https://example.com/x.jpg',
          width: 100,
          height: 100,
          borderRadius: BorderRadius.circular(8),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('.blur(url) renders without throwing', (tester) async {
      await pumpBuilder(
        tester,
        ImageLoader.blur('https://example.com/x.jpg', width: 100, height: 100),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('chained API via `.image` extension', () {
    testWidgets("'url'.image.s100.mk renders an ImageLoader", (tester) async {
      await pumpBuilder(tester, 'https://example.com/x.jpg'.image.s100.mk);
      expect(find.byType(ImageLoader), findsOneWidget);
    });
  });

  group('regression — circle with no radius uses LayoutBuilder', () {
    testWidgets('circle radius=0 wraps in LayoutBuilder (no field mutation)', (tester) async {
      // Verifies the b517865 refactor: LayoutBuilder branch no longer mutates
      // `_width` field. Just check it renders twice in a row without diverging.
      final widget = ImageLoader.circle('https://example.com/x.jpg');
      await pumpBuilder(tester, SizedBox(width: 100, height: 100, child: widget));
      expect(tester.takeException(), isNull);
      await pumpBuilder(tester, SizedBox(width: 200, height: 200, child: widget));
      expect(tester.takeException(), isNull);
    });
  });
}
