import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'adapter_helpers.dart';

/// Verify a builder's color axis applies to the underlying widget's color
/// property. Pass `findRoot` to locate the widget that holds `color` —
/// defaults to `Container` since most builders wrap their child in one.
Future<void> verifyColorAxis(
  WidgetTester tester,
  Widget Function() build, {
  required Color expectedColor,
  Finder? findRoot,
}) async {
  await pumpBuilder(tester, build());
  final root = findRoot ?? find.byType(Container);
  final container = tester.widget<Container>(root);
  final decoration = container.decoration as BoxDecoration?;
  expect(decoration?.color ?? container.color, expectedColor);
}

Future<void> verifyBorderColorAxis(
  WidgetTester tester,
  Widget Function() build, {
  required Color expectedColor,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration?;
  expect(decoration?.border?.top.color, expectedColor);
}

/// Asserts width/height after they've been routed through `Mock2xAdapter`
/// (so an input of `100` becomes `200`).
Future<void> verifySizeAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedW,
  required double expectedH,
}) async {
  await pumpBuilder(tester, build());
  final box = tester.widget<SizedBox>(find.byType(SizedBox).first);
  expect(box.width, expectedW);
  expect(box.height, expectedH);
}

Future<void> verifyWidthAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedW,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  expect(container.constraints?.maxWidth ?? double.infinity, expectedW);
}

Future<void> verifyHeightAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedH,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  expect(container.constraints?.maxHeight ?? double.infinity, expectedH);
}

Future<void> verifyPaddingAxis(
  WidgetTester tester,
  Widget Function() build, {
  required EdgeInsets expected,
}) async {
  await pumpBuilder(tester, build());
  final padding = tester.widget<Padding>(find.byType(Padding).first);
  expect(padding.padding, expected);
}

Future<void> verifyMarginAxis(
  WidgetTester tester,
  Widget Function() build, {
  required EdgeInsets expected,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  expect(container.margin, expected);
}

Future<void> verifyBorderRadiusAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedRadius,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration?;
  expect(decoration?.borderRadius, BorderRadius.circular(expectedRadius));
}

Future<void> verifyBorderWidthAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedWidth,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration?;
  expect(decoration?.border?.top.width, expectedWidth);
}

Future<void> verifyShadowAxis(
  WidgetTester tester,
  Widget Function() build, {
  required int expectedCount,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration?;
  expect(decoration?.boxShadow?.length ?? 0, expectedCount);
}

Future<void> verifySpacingAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expected,
}) async {
  await pumpBuilder(tester, build());
  // Row/Column expose spacing via Flex.spacing (Flutter ≥ 3.27) or via
  // inserted SizedBox children. The library uses Flex.spacing where available.
  final flex = tester.widget<Flex>(find.byType(Flex));
  expect(flex.spacing, expected);
}

Future<void> verifyFontSizeAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expected,
}) async {
  await pumpBuilder(tester, build());
  final text = tester.widget<Text>(find.byType(Text));
  expect(text.style?.fontSize, expected);
}

Future<void> verifyAlignmentAxis(
  WidgetTester tester,
  Widget Function() build, {
  required AlignmentGeometry expected,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  expect(container.alignment, expected);
}

Future<void> verifyOpacityAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expected,
}) async {
  await pumpBuilder(tester, build());
  final opacity = tester.widget<Opacity>(find.byType(Opacity));
  expect(opacity.opacity, expected);
}
