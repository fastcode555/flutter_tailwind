import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_shared/adapter_helpers.dart';

const _png1x1 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk'
    'YAAAAAYAAjCB0C8AAAAASUVORK5CYII=';

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

  // A drawn image must be decoded at its drawn size, along one side only:
  // a full-resolution decode per thumbnail froze a chat holding a dozen
  // large photos, and giving ResizeImage (policy exact) both sides squashed
  // every non-square image.
  group('decode size handed to CachedNetworkImage', () {
    const url = 'https://example.com/x.jpg';

    CachedNetworkImage cni(WidgetTester tester) =>
        tester.widget<CachedNetworkImage>(find.byType(CachedNetworkImage));

    int px(WidgetTester tester, double logical) =>
        (logical * tester.view.devicePixelRatio).toInt();

    testWidgets('a width decodes at that width, keeping the ratio',
        (tester) async {
      await pumpBuilder(tester, url.image.w(100).cover.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, px(tester, w.width!));
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('a sized square still decodes along the width only',
        (tester) async {
      await pumpBuilder(tester, url.image.s100.cover.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, px(tester, w.width!));
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('a rounded image is no longer squashed into its box',
        (tester) async {
      await pumpBuilder(tester, url.image.w(100).rounded8.contain.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, px(tester, w.width!));
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('with only a height, the decode follows the height',
        (tester) async {
      await pumpBuilder(tester, url.image.h(80).cover.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, isNull);
      expect(w.memCacheHeight, isNotNull);
    });

    testWidgets('no size (a full-screen viewer) keeps the original',
        (tester) async {
      await pumpBuilder(tester, url.image.contain.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, isNull);
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('.singleCache opts back into the original resolution',
        (tester) async {
      await pumpBuilder(tester, url.image.singleCache.w(100).cover.mk);
      final w = cni(tester);
      expect(w.memCacheWidth, isNull);
      expect(w.memCacheHeight, isNull);
    });

    // A circle is drawn radius * 2 across; it used to decode at radius
    // (half the size) and along both sides.
    testWidgets('a network circle decodes at its diameter, width only',
        (tester) async {
      await pumpBuilder(tester, ImageLoader.circle(url, radius: 50));
      final w = cni(tester);
      expect(w.memCacheWidth, px(tester, 100));
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('a circle with useSingleCache keeps the original',
        (tester) async {
      await pumpBuilder(
        tester,
        ImageLoader.circle(url, radius: 50, useSingleCache: true),
      );
      final w = cni(tester);
      expect(w.memCacheWidth, isNull);
      expect(w.memCacheHeight, isNull);
    });

    testWidgets('a local file circle decodes at its diameter too',
        (tester) async {
      final dir = Directory.systemTemp.createTempSync('circle_decode');
      addTearDown(() => dir.deleteSync(recursive: true));
      final file = File('${dir.path}/avatar.png')
        ..writeAsBytesSync(base64Decode(_png1x1));
      await pumpBuilder(tester, ImageLoader.circle(file.path, radius: 50));
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      final provider = avatar.backgroundImage! as ResizeImage;
      expect(provider.width, px(tester, 100));
      expect(provider.height, isNull);
    });
  });
}
