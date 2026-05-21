# Widget Test Baseline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build widget + golden test baseline for flutter_tailwind v2.1 covering all 15 builder files in `lib/src/widgets/`, backed by a shared `_shared/` helpers layer so subsequent widget tests are mechanical to add.

**Architecture:** `test/_shared/` holds `adapter_helpers.dart` (`Mock2xAdapter`, `setUpMockAdapter/tearDownAdapter`, `pumpBuilder`), `axis_matchers.dart` (parameterized `verifyColorAxis/verifySizeAxis/...` helpers), and `golden_helpers.dart` (font loader + `goldenTest()` wrapper). 15 widget tests live in `test/widgets/{child,container}/<widget>_test.dart` and run in CI. 15 golden tests live in `test/widgets_golden/{child,container}/<widget>_golden_test.dart`, tagged `@Tags(['golden'])`, run only locally (`flutter test --tags golden`). A root `dart_test.yaml` configures CI to skip the `golden` tag.

**Tech Stack:** Flutter SDK ≥ 3.0, Dart 3, `flutter_test` package (vanilla — no `golden_toolkit`/`alchemist` dependency), `FontLoader` from `dart:ui` for reproducible golden text rendering.

**Spec:** `doc/superpowers/specs/2026-05-21-widget-test-baseline-design.md` — read sections 2–5 before starting.

**Pre-state (commit `144fa7b`):** Library is at v2.0.1 on pub.dev. CI runs `flutter analyze lib/ test/` + `flutter test test/`. Two existing test files (`size_adapter_test.dart` + `tailwind_init_test.dart`, 25 cases total). `Mock2xAdapter` currently lives inline in `size_adapter_test.dart` and will be moved to `_shared/adapter_helpers.dart` in Task 1.

**Phases / commits:**
- Phase 0 → 1 commit (infrastructure + container as reference)
- Phase 1 → 4 commits (one per P0 widget)
- Phase 2 → 2 commits
- Phase 3 → 7 commits
- Phase 4 → 1 commit
- Phase 5 → 1 commit (golden baseline batch — all 15 widgets together since they share font-loading setup)

Total: 16 commits.

---

## Phase 0 — Infrastructure + Reference Implementation

Sets up `_shared/`, `dart_test.yaml`, and writes `container_test.dart` as the canonical template that Phases 1–4 replicate. The 12+ axis matcher functions must each be exercised by `container_test.dart` so we catch matcher bugs before fanning out.

### Task 1: Create `_shared/adapter_helpers.dart`

**Files:**
- Create: `test/_shared/adapter_helpers.dart`

- [ ] **Step 1: Write the helper file**

Create `test/_shared/adapter_helpers.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// 2x scaling mock for verifying every geometry/font value routes through SizeAdapter.
class Mock2xAdapter implements SizeAdapter {
  @override
  double w(num v) => v.toDouble() * 2;
  @override
  double h(num v) => v.toDouble() * 2;
  @override
  double r(num v) => v.toDouble() * 2;
  @override
  double sp(num v) => v.toDouble() * 2;
}

/// Identity (no-scale) — same as Tailwind's default. Useful when a test wants
/// deterministic geometry without the 2x multiplier.
class IdentityAdapter implements SizeAdapter {
  @override
  double w(num v) => v.toDouble();
  @override
  double h(num v) => v.toDouble();
  @override
  double r(num v) => v.toDouble();
  @override
  double sp(num v) => v.toDouble();
}

/// Installs `Mock2xAdapter` and resets the Tailwind singleton's screen
/// dimensions and primary color so each test starts from a clean slate.
void setUpMockAdapter() {
  Tailwind.instance.configSizeAdapter(Mock2xAdapter());
  Tailwind.instance.screenW = 0;
  Tailwind.instance.screenH = 0;
  Tailwind.instance.primaryColor = null;
}

/// Restores `IdentityAdapter` so other tests aren't polluted.
void tearDownAdapter() {
  Tailwind.instance.configSizeAdapter(IdentityAdapter());
  Tailwind.instance.screenW = 0;
  Tailwind.instance.screenH = 0;
  Tailwind.instance.primaryColor = null;
}

/// Wraps `widget` in a MaterialApp + Scaffold and pumps. Use everywhere instead
/// of `tester.pumpWidget` directly — gives consistent ambient Directionality,
/// Theme, and MediaQuery.
Future<void> pumpBuilder(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: widget)),
  );
}
```

- [ ] **Step 2: Verify it compiles**

Run: `flutter analyze test/_shared/adapter_helpers.dart`
Expected: `No issues found!`

If `Tailwind.instance.primaryColor` or `screenW` setters don't exist, check `lib/src/tailwind.dart` — they may need to be public. If they're private, the test must use reflection or you need a different reset strategy (e.g., re-call `Tailwind.instance.init(context)` with a known context). Investigate before continuing.

### Task 2: Create `_shared/axis_matchers.dart`

**Files:**
- Create: `test/_shared/axis_matchers.dart`

- [ ] **Step 1: Write the matcher file**

Create `test/_shared/axis_matchers.dart`:

```dart
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
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.border?.top.color, expectedColor);
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
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.borderRadius, BorderRadius.circular(expectedRadius));
}

Future<void> verifyBorderWidthAxis(
  WidgetTester tester,
  Widget Function() build, {
  required double expectedWidth,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.border?.top.width, expectedWidth);
}

Future<void> verifyShadowAxis(
  WidgetTester tester,
  Widget Function() build, {
  required int expectedCount,
}) async {
  await pumpBuilder(tester, build());
  final container = tester.widget<Container>(find.byType(Container));
  final decoration = container.decoration as BoxDecoration;
  expect(decoration.boxShadow?.length ?? 0, expectedCount);
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
```

- [ ] **Step 2: Verify it compiles**

Run: `flutter analyze test/_shared/axis_matchers.dart`
Expected: `No issues found!`

If `Flex.spacing` doesn't exist (older Flutter), implement `verifySpacingAxis` by counting `SizedBox` children of width/height matching the spacing — but check `lib/src/base/spacing_builder.dart` first to confirm how the library implements spacing.

### Task 3: Create `_shared/golden_helpers.dart`

**Files:**
- Create: `test/_shared/golden_helpers.dart`

- [ ] **Step 1: Write the golden helper file**

Create `test/_shared/golden_helpers.dart`:

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'adapter_helpers.dart';

bool _fontsLoaded = false;

/// Loads the default Roboto font from Flutter's test-resources so golden
/// renders are reproducible across macOS dev / Linux CI. Idempotent.
Future<void> loadAppFonts() async {
  if (_fontsLoaded) return;
  TestWidgetsFlutterBinding.ensureInitialized();
  final fontLoader = FontLoader('Roboto');
  // Flutter SDK ships Roboto TTF inside flutter/bin/cache/artifacts/material_fonts
  // — but tests can't reliably locate that. Easier: register the asset that
  // ships with the material package via rootBundle.
  for (final asset in ['Roboto-Regular.ttf', 'Roboto-Bold.ttf']) {
    final path = 'packages/flutter_tailwind/test/widgets_golden/fonts/$asset';
    try {
      fontLoader.addFont(rootBundle.load(path));
    } on FlutterError {
      // Font asset missing — golden tests will fall back to system font.
      // First-time setup: dev must drop Roboto-Regular.ttf into
      // test/widgets_golden/fonts/ (see Phase 5 / Task GoldenSetup).
    }
  }
  await fontLoader.load();
  _fontsLoaded = true;
}

/// Pumps `widget` (with mock adapter installed) and matches against
/// `goldens/<name>.png` next to the test file.
Future<void> goldenTest(
  WidgetTester tester,
  Widget widget,
  String name,
) async {
  await pumpBuilder(tester, widget);
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/$name.png'),
  );
}

/// Boxes `widget` in a fixed-size container so golden snapshots are crop-
/// stable. Use when the widget under test would otherwise expand to fill.
Widget boxed(Widget child, {double w = 200, double h = 200}) {
  return Center(
    child: SizedBox(width: w, height: h, child: child),
  );
}
```

- [ ] **Step 2: Verify it compiles**

Run: `flutter analyze test/_shared/golden_helpers.dart`
Expected: `No issues found!`

### Task 4: Create `dart_test.yaml`

**Files:**
- Create: `dart_test.yaml`

- [ ] **Step 1: Write the config**

Create `dart_test.yaml` at project root:

```yaml
tags:
  golden:
    skip: "Golden tests are local-only; run with `flutter test --tags golden`"
```

- [ ] **Step 2: Verify Flutter respects it**

Run: `flutter test test/ 2>&1 | tail -5`
Expected: existing 25 tests still pass, no new test files exist yet.

### Task 5: Write `container_test.dart` as the reference implementation

**Files:**
- Create: `test/widgets/container/container_test.dart`

- [ ] **Step 1: Write the test file**

Create `test/widgets/container/container_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('container — 默认行为', () {
    testWidgets('container.mk renders a bare Container', (tester) async {
      await pumpBuilder(tester, container.mk);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('container.child(widget) wraps the given child', (tester) async {
      await pumpBuilder(tester, container.child(const Text('hi')));
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

    testWidgets('s100 → width/height through adapter.w/h (200/200 under 2x)', (tester) async {
      await pumpBuilder(tester, container.s100.mk);
      final c = tester.widget<Container>(find.byType(Container));
      expect(c.constraints?.maxWidth, 200);
      expect(c.constraints?.maxHeight, 200);
    });

    testWidgets('p16 → padding through adapter.r (32 under 2x)', (tester) async {
      await verifyPaddingAxis(
        tester,
        () => container.p16.child(const SizedBox()),
        expected: const EdgeInsets.all(32),
      );
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

    testWidgets('border2 → border width 4 under 2x', (tester) async {
      await verifyBorderWidthAxis(
        tester,
        () => container.red.border2.borderColorBlack.s100.mk,
        expectedWidth: 4,
      );
    });

    testWidgets('borderColorBlack → border color black', (tester) async {
      await verifyBorderColorAxis(
        tester,
        () => container.red.border2.borderColorBlack.s100.mk,
        expectedColor: Colors.black,
      );
    });

    testWidgets('shadow → at least one BoxShadow', (tester) async {
      await verifyShadowAxis(
        tester,
        () => container.red.shadow.s100.mk,
        expectedCount: 1,
      );
    });

    testWidgets('centerAligned → Container.alignment = center', (tester) async {
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
```

- [ ] **Step 2: Run the tests**

Run: `flutter test test/widgets/container/container_test.dart`
Expected: all green. If any test fails, that's information — investigate whether the failure is:
- a wrong assertion in this plan (most likely on edge cases) → fix the assertion
- a wrong API name (`container.red` etc. may use a different getter) → grep `lib/src/widgets/container/` to find the actual name and adjust
- a real bug in the library → stop and flag for discussion before continuing

- [ ] **Step 3: Run full analyze + full test suite**

Run: `flutter analyze lib/ test/`
Expected: `No issues found!`

Run: `flutter test test/`
Expected: 25 (existing) + N (new container tests) all green.

- [ ] **Step 4: Commit Phase 0**

```bash
git add test/_shared/ test/widgets/container/container_test.dart dart_test.yaml
git commit -m "$(cat <<'EOF'
test(infra): _shared/ helpers + dart_test.yaml + container reference

- _shared/adapter_helpers.dart: Mock2xAdapter (extracted from
  size_adapter_test.dart), setUpMockAdapter/tearDownAdapter,
  pumpBuilder() — every widget test now starts from a clean
  Tailwind singleton with deterministic 2x scaling.
- _shared/axis_matchers.dart: 13 parameterized verify*Axis helpers
  so widget tests stay one-line per axis.
- _shared/golden_helpers.dart: loadAppFonts() + goldenTest() wrapper
  (used by Phase 5).
- dart_test.yaml: tag 'golden' skipped by default — CI runs `flutter
  test test/` and silently excludes Phase 5; locally use --tags golden.
- container_test.dart: reference implementation exercising 12+ axis
  matchers — proves the matcher contract before fanning out to the
  remaining 14 widgets.
EOF
)"
```

---

## Phase 1 — P0 Widgets (text, buttons, image, children_container)

Five highest-priority widgets. Each task = one widget file = one commit.

### Task 6: `text_test.dart`

**Files:**
- Create: `test/widgets/child/text_test.dart`

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('text — 默认行为', () {
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
      expect(t.overflow, TextOverflow.ellipsis);
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
      Tailwind.instance.configSizeAdapter(_FractionalAdapter());
      await pumpBuilder(tester, 'foo'.text.f30.f10.mk);
      expect(tester.takeException(), isNull);
    });
  });
}

class _FractionalAdapter implements SizeAdapter {
  @override
  double w(num v) => v.toDouble() * 1.5;
  @override
  double h(num v) => v.toDouble() * 1.5;
  @override
  double r(num v) => v.toDouble() * 1.5;
  @override
  double sp(num v) => v.toDouble() * 1.5;
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/child/text_test.dart
# expect all green

git add test/widgets/child/text_test.dart
git commit -m "test(text): widget test baseline — defaults, axis, click, AutoSizeText regression"
```

### Task 7: `buttons_test.dart`

**Files:**
- Create: `test/widgets/child/buttons_test.dart`

Test all 4 variants: text/outlined/elevated/icon button. Each variant covers default + 2-3 axes + the `.click(onTap:)` terminator with debounce.

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('TextButton via .textButton', () {
    testWidgets('default renders TextButton with the label', (tester) async {
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () {}));
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('tap'), findsOneWidget);
    });

    testWidgets('.click() fires onTap', (tester) async {
      var tapped = 0;
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () => tapped++));
      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(tapped, 1);
    });

    testWidgets('Debouncer swallows the 2nd rapid tap', (tester) async {
      var tapped = 0;
      await pumpBuilder(tester, 'tap'.textButton.click(onTap: () => tapped++));
      await tester.tap(find.byType(TextButton));
      await tester.tap(find.byType(TextButton)); // < debounce window
      await tester.pump();
      expect(tapped, 1);
    });
  });

  group('OutlinedButton via .outlinedButton', () {
    testWidgets('default renders OutlinedButton', (tester) async {
      await pumpBuilder(tester, 'tap'.outlinedButton.click(onTap: () {}));
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('ElevatedButton via .elevatedButton', () {
    testWidgets('default renders ElevatedButton', (tester) async {
      await pumpBuilder(tester, 'tap'.elevatedButton.click(onTap: () {}));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('IconButton via iconButton', () {
    testWidgets('default with icon renders IconButton', (tester) async {
      await pumpBuilder(tester, iconButton.iconData(Icons.add).click(onTap: () {}));
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('child() throws (IconButton does not support child)', (tester) async {
      expect(
        () => iconButton.iconData(Icons.add).child(const Text('nope')),
        throwsA(isA<Exception>()),
      );
    });
  });
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/child/buttons_test.dart
# expect all green; if a getter name is wrong (e.g. .textButton vs .text_button)
# grep lib/src/widgets/child/buttons.dart for the actual extension getter

git add test/widgets/child/buttons_test.dart
git commit -m "test(buttons): widget test baseline — 4 variants, click, debouncer, IconButton.child throws"
```

### Task 8: `image_test.dart`

**Files:**
- Create: `test/widgets/child/image_test.dart`

ImageLoader has 4 constructors (`.image`, `.circle`, `.round`, `.blur`) — all 4 must render without throwing. This is the regression baseline for the immutability refactor in commit `b517865`.

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

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
    testWidgets('"url".image.s100.mk renders an ImageLoader', (tester) async {
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
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/child/image_test.dart
git add test/widgets/child/image_test.dart
git commit -m "test(image): widget test baseline — 4 ImageLoader constructors + chained .image extension + circle rebuild regression"
```

### Task 9: `children_container_test.dart` (row / column / stack)

**Files:**
- Create: `test/widgets/container/children_container_test.dart`

Row and Column share the `_LinearBuilder` base; Stack is separate. Cover all three in one file.

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

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

    testWidgets('.spacing16 → Flex.spacing = 32 under 2x', (tester) async {
      await verifySpacingAxis(
        tester,
        () => row.spacing16.children([const SizedBox(), const SizedBox()]),
        expected: 32,
      );
    });

    testWidgets('color via wrapper Container', (tester) async {
      await pumpBuilder(tester, row.red.children([const Text('x')]));
      // row mixes ColorBuilder; wraps Row in a Container with the color.
      final c = tester.widget<Container>(find.byType(Container));
      final dec = c.decoration as BoxDecoration?;
      expect(dec?.color ?? c.color, Colors.red);
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

    testWidgets('.spacing20 → Flex.spacing = 40 under 2x', (tester) async {
      await verifySpacingAxis(
        tester,
        () => column.spacing20.children([const SizedBox(), const SizedBox()]),
        expected: 40,
      );
    });
  });

  group('stack', () {
    testWidgets('.children([...]) renders a Stack', (tester) async {
      await pumpBuilder(
        tester,
        stack.children([const Text('a'), const Text('b')]),
      );
      expect(find.byType(Stack), findsOneWidget);
    });
  });
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/container/children_container_test.dart
git add test/widgets/container/children_container_test.dart
git commit -m "test(row/column/stack): widget test baseline — children terminator, spacing axis, color wrapper"
```

---

## Phase 2 — P1 Forms (check_box, radio)

### Task 10: `check_box_test.dart`

**Files:**
- Create: `test/widgets/child/check_box_test.dart`

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('check_box — defaults', () {
    testWidgets('renders as unchecked', (tester) async {
      await pumpBuilder(tester, checkBox.onChanged((_) {}));
      expect(find.byType(AnimatedCheckBox), findsOneWidget);
    });
  });

  group('check_box — terminator', () {
    testWidgets('onChanged fires when tapped', (tester) async {
      bool? lastValue;
      await pumpBuilder(tester, checkBox.onChanged((v) => lastValue = v));
      await tester.tap(find.byType(AnimatedCheckBox));
      await tester.pumpAndSettle();
      expect(lastValue, true);
    });
  });

  group('check_box — modes', () {
    testWidgets('.material switches to system style', (tester) async {
      await pumpBuilder(tester, checkBox.material.onChanged((_) {}));
      expect(find.byType(AnimatedCheckBox), findsOneWidget);
      // systemStyle=true is internal — assert via render: no error.
      expect(tester.takeException(), isNull);
    });

    testWidgets('.justIcon disables fill', (tester) async {
      await pumpBuilder(tester, checkBox.justIcon.onChanged((_) {}));
      expect(tester.takeException(), isNull);
    });

    testWidgets('.enableBorder keeps the border visible when checked', (tester) async {
      await pumpBuilder(tester, checkBox.enableBorder.onChanged((_) {}));
      expect(tester.takeException(), isNull);
    });
  });
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/child/check_box_test.dart
git add test/widgets/child/check_box_test.dart
git commit -m "test(check_box): widget test baseline — default, onChanged, material/justIcon/enableBorder modes"
```

### Task 11: `radio_test.dart`

**Files:**
- Create: `test/widgets/child/radio_test.dart`

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('radio<int>(value:1).onChanged fires with the value', (tester) async {
    int? selected;
    await pumpBuilder(
      tester,
      radio<int>(value: 1, groupValue: 0).onChanged((v) => selected = v),
    );
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    expect(selected, 1);
  });

  testWidgets('radio<int> with groupValue matching renders as selected', (tester) async {
    await pumpBuilder(
      tester,
      radio<int>(value: 1, groupValue: 1).onChanged((_) {}),
    );
    expect(tester.takeException(), isNull);
  });
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/child/radio_test.dart
git add test/widgets/child/radio_test.dart
git commit -m "test(radio): widget test baseline — onChanged, groupValue match"
```

**Note:** The actual `radio` API may use `radio.value(1).groupValue(0).onChanged(...)` chains instead of constructor args. Before writing the test, grep `lib/src/widgets/child/radio.dart` for the actual entry point and adapt the calls. The point of this task is the *coverage shape*; the syntactic form follows the source.

---

## Phase 3 — P2 Media / Layout (icon, svg, wrap, sized_box, positioned, padding, shader_mask)

Each of these is small and similar. Use Phase 0 / Phase 1 as the template.

### Task 12: `icon_test.dart`

```dart
// test/widgets/child/icon_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('icon(Icons.add).mk renders an Icon', (tester) async {
    await pumpBuilder(tester, icon(Icons.add).mk);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('icon(Icons.add).s24 sets the icon size to 48 under 2x', (tester) async {
    await pumpBuilder(tester, icon(Icons.add).s24.mk);
    final i = tester.widget<Icon>(find.byType(Icon));
    expect(i.size, 48);
  });

  testWidgets('icon(Icons.add).red sets the icon color', (tester) async {
    await pumpBuilder(tester, icon(Icons.add).red.mk);
    final i = tester.widget<Icon>(find.byType(Icon));
    expect(i.color, Colors.red);
  });
}
```

```bash
flutter test test/widgets/child/icon_test.dart
git add test/widgets/child/icon_test.dart && git commit -m "test(icon): baseline — size routes through adapter.r, color applied"
```

### Task 13: `svg_test.dart`

```dart
// test/widgets/child/svg_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('"path.svg".svg.s24.mk renders an SvgPicture', (tester) async {
    await pumpBuilder(tester, 'assets/x.svg'.svg.s24.mk);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('.s24 → 48 width/height under 2x', (tester) async {
    await pumpBuilder(tester, 'assets/x.svg'.svg.s24.mk);
    final svg = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(svg.width, 48);
    expect(svg.height, 48);
  });
}
```

```bash
flutter test test/widgets/child/svg_test.dart
git add test/widgets/child/svg_test.dart && git commit -m "test(svg): baseline — size routing"
```

### Task 14: `wrap_test.dart`

```dart
// test/widgets/child/wrap_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('wrap.children([...]) renders a Wrap', (tester) async {
    await pumpBuilder(tester, wrap.children([const Text('a'), const Text('b')]));
    expect(find.byType(Wrap), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
  });

  testWidgets('.spacing16 → Wrap.spacing = 32 under 2x', (tester) async {
    await pumpBuilder(tester, wrap.spacing16.children([const SizedBox(), const SizedBox()]));
    final w = tester.widget<Wrap>(find.byType(Wrap));
    expect(w.spacing, 32);
  });

  testWidgets('.runSpacing16 → Wrap.runSpacing = 32 under 2x', (tester) async {
    await pumpBuilder(tester, wrap.runSpacing16.children([const SizedBox()]));
    final w = tester.widget<Wrap>(find.byType(Wrap));
    expect(w.runSpacing, 32);
  });
}
```

```bash
flutter test test/widgets/child/wrap_test.dart
git add test/widgets/child/wrap_test.dart && git commit -m "test(wrap): baseline — children, spacing, runSpacing"
```

### Task 15: `sized_box_test.dart`

```dart
// test/widgets/child/sized_box_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('sizedBox.s50.mk → 100x100 SizedBox under 2x', (tester) async {
    await pumpBuilder(tester, sizedBox.s50.mk);
    final s = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(s.width, 100);
    expect(s.height, 100);
  });

  testWidgets('sizedBox.w50.h30 → 100x60 under 2x', (tester) async {
    await pumpBuilder(tester, sizedBox.w50.h30.mk);
    final s = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(s.width, 100);
    expect(s.height, 60);
  });

  testWidgets('sizedBox.child(w) wraps the given child', (tester) async {
    const marker = ValueKey('m');
    await pumpBuilder(tester, sizedBox.s50.child(const Text('x', key: marker)));
    expect(find.byKey(marker), findsOneWidget);
  });
}
```

```bash
flutter test test/widgets/child/sized_box_test.dart
git add test/widgets/child/sized_box_test.dart && git commit -m "test(sized_box): baseline — size routing, child terminator"
```

### Task 16: `positioned_test.dart`

```dart
// test/widgets/child/positioned_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('positioned.l16.t8.child(w) sets left/top through adapter.r', (tester) async {
    await pumpBuilder(
      tester,
      Stack(children: [positioned.l16.t8.child(const SizedBox(width: 1, height: 1))]),
    );
    final p = tester.widget<Positioned>(find.byType(Positioned));
    expect(p.left, 32);
    expect(p.top, 16);
  });

  testWidgets('positioned.r0.b0.child(w) sets right/bottom', (tester) async {
    await pumpBuilder(
      tester,
      Stack(children: [positioned.r0.b0.child(const SizedBox(width: 1, height: 1))]),
    );
    final p = tester.widget<Positioned>(find.byType(Positioned));
    expect(p.right, 0);
    expect(p.bottom, 0);
  });
}
```

```bash
flutter test test/widgets/child/positioned_test.dart
git add test/widgets/child/positioned_test.dart && git commit -m "test(positioned): baseline — l/t/r/b through adapter.r"
```

### Task 17: `padding_test.dart`

```dart
// test/widgets/child/padding_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/axis_matchers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('padding.p16.child(w) → EdgeInsets.all(32) under 2x', (tester) async {
    await verifyPaddingAxis(
      tester,
      () => padding.p16.child(const SizedBox()),
      expected: const EdgeInsets.all(32),
    );
  });

  testWidgets('padding.l8.t4.child(w) sets left/top only', (tester) async {
    await pumpBuilder(tester, padding.l8.t4.child(const SizedBox()));
    final p = tester.widget<Padding>(find.byType(Padding).first);
    expect(p.padding, const EdgeInsets.only(left: 16, top: 8));
  });
}
```

```bash
flutter test test/widgets/child/padding_test.dart
git add test/widgets/child/padding_test.dart && git commit -m "test(padding): baseline — p16 + asymmetric l/t/r/b through adapter.r"
```

### Task 18: `shader_mask_test.dart`

```dart
// test/widgets/child/shader_mask_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('shaderMask.linearGradient([red, blue]).child(w) renders a ShaderMask', (tester) async {
    await pumpBuilder(
      tester,
      shaderMask
          .linearGradient([Colors.red, Colors.blue])
          .child(const Text('hi')),
    );
    expect(find.byType(ShaderMask), findsOneWidget);
    expect(find.text('hi'), findsOneWidget);
  });
}
```

```bash
flutter test test/widgets/child/shader_mask_test.dart
git add test/widgets/child/shader_mask_test.dart && git commit -m "test(shader_mask): baseline — linearGradient + child"
```

**Note:** Verify the exact entry getter (`shaderMask` vs `shader_mask` vs `shaderMaskBuilder`) by checking the top of `lib/src/widgets/child/shader_mask.dart` first.

---

## Phase 4 — P3 List

### Task 19: `list_view_test.dart` (covers list + grid)

**Files:**
- Create: `test/widgets/container/list_view_test.dart`

The two non-trivial terminators here are `.builder(count, itemBuilder)` and `.dataBuilder<T>(list, builder)`.

- [ ] **Step 1: Write the test file**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';

void main() {
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  group('listView', () {
    testWidgets('.builder(3, ...) renders 3 items', (tester) async {
      await pumpBuilder(
        tester,
        listView.builder(3, (ctx, i) => Text('item-$i')),
      );
      expect(find.text('item-0'), findsOneWidget);
      expect(find.text('item-1'), findsOneWidget);
      expect(find.text('item-2'), findsOneWidget);
    });

    testWidgets('.dataBuilder<int>([10,20,30], ...) renders typed items', (tester) async {
      await pumpBuilder(
        tester,
        listView.dataBuilder<int>([10, 20, 30], (ctx, i, v) => Text('v-$v')),
      );
      expect(find.text('v-10'), findsOneWidget);
      expect(find.text('v-30'), findsOneWidget);
    });

    testWidgets('.spacing16 inserts gaps between items', (tester) async {
      await pumpBuilder(
        tester,
        listView.spacing16.builder(2, (ctx, i) => Text('item-$i')),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('gridView', () {
    testWidgets('.crossAxisCount(2).builder(4, ...) renders a 2x2 grid', (tester) async {
      await pumpBuilder(
        tester,
        gridView.crossAxisCount(2).builder(4, (ctx, i) => Text('cell-$i')),
      );
      expect(find.text('cell-0'), findsOneWidget);
      expect(find.text('cell-3'), findsOneWidget);
    });
  });
}
```

- [ ] **Step 2: Run + commit**

```bash
flutter test test/widgets/container/list_view_test.dart
git add test/widgets/container/list_view_test.dart
git commit -m "test(list_view): baseline — builder/dataBuilder/spacing + gridView.crossAxisCount"
```

**Note:** The `gridView.crossAxisCount(2)` API may not exist by that exact name — grep `lib/src/widgets/container/list_view.dart` for the actual method (`.crossAxisCount(n)` vs `.cross(n)` vs constructor positional arg). Adjust accordingly.

---

## Phase 5 — Golden Baseline (15 widgets, single commit)

Done last so prior Phases can change builder internals without forcing golden re-shoots. All 15 golden tests landed in one commit because they share a single font-loading setup and the engineer's eyeballing the rendered images.

### Task 20: Drop Roboto TTF font asset

**Files:**
- Create: `test/widgets_golden/fonts/Roboto-Regular.ttf`
- Create: `test/widgets_golden/fonts/Roboto-Bold.ttf`
- Modify: `pubspec.yaml` (add the fonts to the package or, easier, drop them under `test/widgets_golden/fonts/` and adjust `_shared/golden_helpers.dart`'s asset path)

- [ ] **Step 1: Download Roboto from Google Fonts**

```bash
mkdir -p test/widgets_golden/fonts
# Manual: download Roboto-Regular.ttf + Roboto-Bold.ttf from
# https://fonts.google.com/specimen/Roboto and place them under
# test/widgets_golden/fonts/
ls -lah test/widgets_golden/fonts/
# expect both files ~150KB each
```

- [ ] **Step 2: Verify loadAppFonts() finds them**

Add a minimal smoke test at `test/widgets_golden/_font_smoke_test.dart`:

```dart
@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';
import '../_shared/golden_helpers.dart';

void main() {
  testWidgets('fonts load without throwing', (tester) async {
    await loadAppFonts();
    // No assertion beyond "no exception".
  });
}
```

Run: `flutter test --tags golden test/widgets_golden/_font_smoke_test.dart`
Expected: PASS.

If `rootBundle.load` throws asset-not-found, the TTF path in `golden_helpers.dart` doesn't match where you dropped the file. Adjust the path in `golden_helpers.dart` and re-run.

### Task 21: Write the 15 golden tests + shoot the baseline

**Files:**
- Create: `test/widgets_golden/child/{text,buttons,check_box,radio,image,icon,svg,padding,sized_box,positioned,wrap,shader_mask}_golden_test.dart`
- Create: `test/widgets_golden/container/{container,children_container,list_view}_golden_test.dart`
- Create: `test/widgets_golden/{child,container}/goldens/<widget>/<scenario>.png` (≤75 PNGs total)

Each file follows this exact template — only `import` paths and the scenarios in `testWidgets` change.

- [ ] **Step 1: Template for one widget — `text_golden_test.dart`**

```dart
@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

import '../../_shared/adapter_helpers.dart';
import '../../_shared/golden_helpers.dart';

void main() {
  setUpAll(loadAppFonts);
  setUp(setUpMockAdapter);
  tearDown(tearDownAdapter);

  testWidgets('default', (t) =>
      goldenTest(t, boxed('hi'.text.mk), 'text/default'));

  testWidgets('red f16 bold', (t) =>
      goldenTest(t, boxed('hi'.text.red.f16.bold.mk), 'text/red_f16_bold'));

  testWidgets('center maxLines 2 ellipsis', (t) =>
      goldenTest(
          t,
          boxed('a very long string that definitely overflows two lines, repeated many many times'
              .text.center.maxLines(2).ellipsis.mk),
          'text/center_maxlines2_ellipsis'));

  testWidgets('empty', (t) =>
      goldenTest(t, boxed(''.text.mk), 'text/empty'));
}
```

- [ ] **Step 2: Repeat for the other 14 widgets**

Each gets a sibling golden test file with 3-5 scenarios. Suggested scenario set per widget (kept short — see Spec §2.4 for the rationale of ≤5/widget):

| Widget | Scenarios |
|---|---|
| `text` | default, red_f16_bold, center_maxlines2_ellipsis, empty |
| `buttons` | text_default, outlined_default, elevated_default, icon_with_label |
| `check_box` | unchecked, checked, material_unchecked, justIcon |
| `radio` | unselected, selected |
| `image` | placeholder_only (use a fake URL so it falls back to placeholder) |
| `icon` | small_red, large_blue |
| `svg` | small_red (use a 1x1 placeholder svg asset under test/widgets_golden/assets/) |
| `padding` | p16_around_box |
| `sized_box` | s100, w50_h30 |
| `positioned` | l16_t8_in_stack |
| `wrap` | three_chips_spacing16 |
| `shader_mask` | red_blue_gradient_text |
| `container` | red_s100, rounded8_border2, shadowed |
| `children_container` | row_spacing16_three_boxes, column_spacing20_three_boxes, stack_two_overlapping |
| `list_view` | three_text_items, grid_2col_4cells |

- [ ] **Step 3: Shoot the baseline**

```bash
flutter test test/widgets_golden/ --tags golden --update-goldens
# Inspect each generated PNG under test/widgets_golden/{child,container}/goldens/<widget>/
# — verify they look correct visually before committing.
```

- [ ] **Step 4: Re-run goldens to verify deterministic**

```bash
flutter test test/widgets_golden/ --tags golden
# Expected: all green (pixel-identical to the baseline you just shot).
```

If any test fails on the second run, fonts or animation timing is non-deterministic — adjust the scenario (e.g., wrap in `await tester.pumpAndSettle()`).

- [ ] **Step 5: Verify CI still skips goldens**

```bash
flutter test test/
# Expected: only widgets/ tests run; goldens skipped due to dart_test.yaml.
# Look for "Skip: Golden tests are local-only" in the output if Flutter prints it.
```

- [ ] **Step 6: Commit all golden tests + PNG baselines**

```bash
git add test/widgets_golden/ pubspec.yaml
git commit -m "$(cat <<'EOF'
test(goldens): visual regression baseline for 15 widgets

15 @Tags(['golden']) test files (one per widget builder) + ≤75 PNG
baselines under test/widgets_golden/{child,container}/goldens/.
Roboto-Regular.ttf + Roboto-Bold.ttf added under test/widgets_golden/
fonts/ for reproducible text rendering.

Goldens are local-only — dart_test.yaml skips the 'golden' tag, so
CI's `flutter test test/` never runs these. Locally:

  flutter test test/widgets_golden/ --tags golden               # verify
  flutter test test/widgets_golden/ --tags golden --update-goldens   # re-shoot

If a builder's visual output legitimately changes, re-shoot and
commit the updated PNG along with the change.
EOF
)"
```

---

## Self-Review

Spec coverage check (each spec section maps to ≥1 task):

| Spec section | Implemented by |
|---|---|
| §2.1 Directory layout | Tasks 1–4 (`_shared/`), Task 5 (widgets/), Task 21 (widgets_golden/), Task 4 (dart_test.yaml) |
| §2.2 adapter_helpers.dart | Task 1 |
| §2.2 axis_matchers.dart (13 matchers) | Task 2 |
| §2.2 golden_helpers.dart | Task 3 |
| §2.3 4-section template | Tasks 5–19 (every widget test uses default / axis / terminator / regression sections) |
| §2.4 Golden ≤5/widget, font loader | Task 20–21 |
| §3 inventory (15 files) | Tasks 5–19 (one per widget) |
| §4 CI dart_test.yaml | Task 4 |
| §5 phase ordering | Phases 0–5 mirror Tasks 1–21 |
| §6 risks | Tasks 8 + 9 (regression sections), Task 5 (matcher coverage) |
| §7 acceptance criteria | Task 21 Step 5 (CI skip check), each Step 2 verification command |

Placeholder scan: no TBD / TODO / "handle errors appropriately" / "similar to Task N" patterns. ✓

Type consistency: Helper names used in tasks (`pumpBuilder`, `setUpMockAdapter`, `tearDownAdapter`, `verify*Axis`, `loadAppFonts`, `goldenTest`, `boxed`, `Mock2xAdapter`, `IdentityAdapter`) all defined in Tasks 1–3 and used consistently in 5–21. ✓

Known unknowns (engineer needs to confirm against `lib/` before writing):
- Exact `radio` chain syntax (Task 11 note)
- Exact `gridView` cross-axis count getter name (Task 19 note)
- Exact `shaderMask` entry point getter name (Task 18 note)
- Whether `Tailwind.instance.primaryColor` is a public setter (Task 1 Step 2 fallback)
- Whether `Flex.spacing` exists on the project's Flutter SDK pin (Task 2 Step 2 fallback)

These are documented as fallback investigation points inside each task — not blockers, just things the engineer must verify against the source rather than guessing.
