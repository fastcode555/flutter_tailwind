# SizeAdapter v2.0 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the per-call `.adaptW/.adaptH/.adaptR/.adaptSp` opt-in API (and the implicit `flutter_screenutil` dependency it implied) with a single globally-configured `SizeAdapter` abstraction. Ship as v2.0.0.

**Architecture:** A new `SizeAdapter` interface (4 methods: `w/h/r/sp`) lives on the `Tailwind` singleton. Library defaults to `IdentitySizeAdapter` (no scaling). All builder `mk` methods route geometry/font values through top-level `sw/sh/sr/ssp` helpers that read the active adapter. Users plug in their own adapter (e.g. wrapping `flutter_screenutil`) in 4 lines.

**Tech Stack:** Flutter SDK ≥ 3.0, Dart 3, `flutter_test` for widget tests, `dart:ui` for `Color/Size`, project uses `fvm` for Flutter version pinning.

**Spec:** `doc/superpowers/specs/2026-05-16-size-adapter-v2-design.md` — sections 3–9 inform the task code.

**Pre-state (commit `5d60579`):** User already deleted `adaptW/H/R/Sp` getters, `flutter_screenutil` from pubspec, the screenutil export from `lib/flutter_tailwind.dart`, and `CustomSp.csp` from `font_size_builder.dart`. Three files still reference screenutil and break the build: `lib/src/widgets/child/widgets.dart` (import + `REdgeInsets`), `lib/src/base/size_builder.dart` (`ScreenUtil()` calls), `lib/src/image_loader/image_loader.dart` (`ScreenUtil().pixelRatio`). Phase 1 fixes those plus introduces the new abstraction.

---

## Phase 1: Foundation (un-break the build + new abstraction)

### Task 1: Create `SizeAdapter` interface + `IdentitySizeAdapter` + top-level helpers

**Files:**
- Create: `lib/src/adapters/size_adapter.dart`
- Test: `test/size_adapter_test.dart` (Task 16 fleshes this out; this task adds the bootstrap test only)

- [ ] **Step 1: Write the bootstrap test (Identity returns originals)**

Create `test/size_adapter_test.dart`:

```dart
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
```

- [ ] **Step 2: Run test to verify it fails (import unresolved)**

```bash
cd /Users/barry/Code/github/flutter_tailwind
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

Expected: failure — `Undefined name 'IdentitySizeAdapter'` (the type doesn't exist yet).

- [ ] **Step 3: Create the adapter file**

Create `lib/src/adapters/size_adapter.dart`:

```dart
import 'package:flutter_tailwind/src/tailwind.dart';

/// Pure value-scaling abstraction. Implementations decide how a raw
/// number from a builder chain should map to a device-adjusted number.
///
/// The library defaults to [IdentitySizeAdapter] (no scaling) so projects
/// that don't need responsive sizing get exactly the values they write.
///
/// To integrate flutter_screenutil, responsive_framework, sizer, or any
/// custom solution, implement this interface and inject via
/// `Tailwind.instance.configSizeAdapter(...)`.
///
/// See `doc/patterns/screen-adaptation.md` for an end-to-end example.
abstract class SizeAdapter {
  /// Scale a width-direction value (Container width, etc.).
  double w(double value);

  /// Scale a height-direction value.
  double h(double value);

  /// Scale a responsive value (typically uses min(width, height) factor).
  /// Used for radii, square sizes, paddings, margins, positions, shadows.
  double r(double value);

  /// Scale a font size. Often differs from [r] because of platform
  /// text-scale settings.
  double sp(double value);
}

/// Default implementation. Returns every value unchanged.
class IdentitySizeAdapter implements SizeAdapter {
  const IdentitySizeAdapter();

  @override
  double w(double v) => v;

  @override
  double h(double v) => v;

  @override
  double r(double v) => v;

  @override
  double sp(double v) => v;
}

// ───────────────── Top-level helpers ─────────────────
// Internal shorthand for the verbose
// `Tailwind.instance.sizeAdapter.{w,h,r,sp}(v)` chain. Library code
// should prefer these; user code can use either form.

SizeAdapter get _adapter => Tailwind.instance.sizeAdapter;

double sw(double v) => _adapter.w(v);
double sh(double v) => _adapter.h(v);
double sr(double v) => _adapter.r(v);
double ssp(double v) => _adapter.sp(v);
```

- [ ] **Step 4: Re-export from public surface**

Modify `lib/flutter_tailwind.dart` — add line after the existing exports (alphabetical position is fine to keep diff small; put it next to other `src/...` exports):

```dart
export 'src/adapters/size_adapter.dart';
```

- [ ] **Step 5: Run tests to verify they pass**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

Expected: all 4 tests pass.

Note: at this point `lib/` still has 3 broken files referencing screenutil. We will not run `flutter analyze lib/` until Task 5. The test only imports the new adapter file plus the public surface re-export, so it can compile in isolation **only if** the unrelated broken files aren't transitively touched. If the test fails to compile because of unrelated lib errors, defer the test run to after Task 5.

- [ ] **Step 6: Commit**

```bash
git add lib/src/adapters/size_adapter.dart lib/flutter_tailwind.dart test/size_adapter_test.dart
git commit -m "feat: add SizeAdapter abstraction + IdentitySizeAdapter

v2.0 foundation. The interface has 4 methods (w/h/r/sp) matching
screenutil's API shape so users can write a 4-line wrapper to plug
their preferred screen-scaling library in.

Top-level helpers sw/sh/sr/ssp give internal builder code a terse
syntax for routing values through the active adapter.

Default is IdentitySizeAdapter (no scaling) — projects that don't
need responsive sizing get exactly the values they write."
```

---

### Task 2: Refactor `Tailwind` singleton

**Files:**
- Modify: `lib/src/tailwind.dart` (full rewrite — file is small)
- Test: `test/tailwind_primary_test.dart` will be replaced in Task 17; for this task we only sanity-check that existing tests still pass under the new shape

**Spec references:** § 4.1, 4.2, 4.3, 4.4

- [ ] **Step 1: Write the new Tailwind file**

Replace `lib/src/tailwind.dart` entirely with:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/adapters/size_adapter.dart';
import 'package:flutter_tailwind/src/image_loader/base_image_factory.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader_config.dart';

/// Singleton holding library-wide configuration.
///
/// Configurable:
///   - [sizeAdapter] — install via [configSizeAdapter] to enable
///     screen-scaling. Defaults to [IdentitySizeAdapter] (no scaling).
///   - [primaryColor] — read from [init]'s context or set directly.
///   - [imageFactory] / image loader — see [configImageFactory].
///
/// Cached by [init]:
///   - [screenW], [screenH] — populated from MediaQuery at init time.
///     Used by the hFull/wFull/sScreen/sFull-family getters.
///
/// Important: [init] requires a BuildContext that is inside the
/// MaterialApp widget tree. The context is NOT retained — values are
/// extracted immediately and cached to fields.
class Tailwind {
  static Tailwind? _instance;

  factory Tailwind() => _getInstance();

  static Tailwind get instance => _getInstance();

  Tailwind._internal();

  static Tailwind _getInstance() => _instance ??= Tailwind._internal();

  /// The active size adapter. Defaults to identity (no scaling).
  /// Replace via [configSizeAdapter].
  SizeAdapter sizeAdapter = const IdentitySizeAdapter();

  /// Cached screen width in logical pixels. Populated by [init].
  /// Returns 0.0 if [init] hasn't been called yet.
  double screenW = 0.0;

  /// Cached screen height in logical pixels. Populated by [init].
  /// Returns 0.0 if [init] hasn't been called yet.
  double screenH = 0.0;

  Color? primaryColor;

  BaseImageFactory? imageFactory;

  /// Returns the active primary color.
  /// Resolution: [primaryColor] (populated by [init] or set directly) ??
  /// [Colors.amber].
  Color get primary => primaryColor ?? Colors.amber;

  /// One-shot setup. Pulls needed values out of [context] *immediately*
  /// and caches them; does NOT retain the context reference.
  ///
  /// Must be called with a context inside the MaterialApp widget tree
  /// (typically `MaterialApp.builder` or the home page's `build`).
  /// If called from above MaterialApp (e.g. `ScreenUtilInit.builder`),
  /// MediaQuery lookup returns null and screenW/screenH stay 0.
  void init(BuildContext context, [Color? fallbackPrimary]) {
    final mq = MediaQuery.maybeOf(context);
    if (mq != null) {
      screenW = mq.size.width;
      screenH = mq.size.height;
    }
    primaryColor = fallbackPrimary ?? Theme.of(context).primaryColor;
    // context intentionally NOT stored
  }

  /// Install a custom size adapter. Typical call site: app startup.
  void configSizeAdapter(SizeAdapter adapter) {
    sizeAdapter = adapter;
  }

  void addImageConfig(ImageLoaderConfigInterface imageConfig) {
    ImageLoader.init(imageConfig);
  }

  void configImageFactory(BaseImageFactory imageFactory) {
    this.imageFactory = imageFactory;
  }
}
```

Note differences from v1.8:
- `context` field removed
- `.primary` getter simplified — no `Theme.of`, no try-catch
- Added `sizeAdapter`, `screenW`, `screenH` fields
- Added `configSizeAdapter` method
- `init` now uses MediaQuery + extracts immediately

- [ ] **Step 2: Verify the file compiles by importing it**

```bash
flutter analyze lib/src/tailwind.dart 2>&1 | tail -5
```

Expected: clean OR errors only about UNRELATED files (the 3 still-broken screenutil files). The `tailwind.dart` file itself must show no errors.

- [ ] **Step 3: Run the existing primary-test file to see what breaks**

```bash
flutter test test/tailwind_primary_test.dart 2>&1 | tail -10
```

Expected: most tests fail because the test sets `Tailwind.instance.context = ...` (a field that no longer exists). We are NOT fixing the test in this task — Task 17 will rewrite the test file. For now, accept the failure.

- [ ] **Step 4: Commit**

```bash
git add lib/src/tailwind.dart
git commit -m "refactor: Tailwind singleton — remove context, add sizeAdapter + screenW/H

Singleton no longer retains a BuildContext. init() extracts the values
it needs (MediaQuery.size, Theme.primaryColor) immediately and caches
them to fields. Eliminates the deactivated-context throw scenario
v1.8 had to try-catch around.

New fields:
  - sizeAdapter (defaults to IdentitySizeAdapter)
  - screenW / screenH (cached at init, 0.0 if uninit)

New method:
  - configSizeAdapter(adapter)

The .primary getter is now a one-liner: primaryColor ?? Colors.amber.

Breaks the tailwind_primary_test.dart suite (uses removed .context
field). That test file is replaced wholesale in a later task."
```

---

### Task 3: Fix `size_builder._screenH/_screenW` to read from Tailwind

**Files:**
- Modify: `lib/src/base/size_builder.dart:70-72`

**Spec references:** § 6.1

- [ ] **Step 1: Locate the current implementation**

```bash
sed -n '68,75p' lib/src/base/size_builder.dart
```

Expected output: shows the current `_screenH/_screenW` definitions calling `ScreenUtil()`.

- [ ] **Step 2: Replace the getters**

Edit `lib/src/base/size_builder.dart` — replace lines that look like:

```dart
double get _screenH => ScreenUtil().screenHeight;

double get _screenW => ScreenUtil().screenWidth;
```

with:

```dart
double get _screenH {
  final h = Tailwind.instance.screenH;
  assert(h > 0,
      'Tailwind.instance.init(context) must be called before using '
      'hFull/wFull/sScreen/sFull-family getters. '
      'See doc/getting-started.md for the correct init location.');
  return h;
}

double get _screenW {
  final w = Tailwind.instance.screenW;
  assert(w > 0,
      'Tailwind.instance.init(context) must be called before using '
      'hFull/wFull/sScreen/sFull-family getters. '
      'See doc/getting-started.md for the correct init location.');
  return w;
}
```

- [ ] **Step 3: Verify the screenutil import is no longer needed in this file**

```bash
grep -n "flutter_screenutil\|ScreenUtil" lib/src/base/size_builder.dart
```

Expected: no matches. The user already deleted the import in commit `5d60579`; the call sites we just removed were the only consumers.

- [ ] **Step 4: Add the Tailwind import if missing**

Verify the file imports the singleton:

```bash
head -5 lib/src/base/size_builder.dart
```

If `import 'package:flutter_tailwind/src/tailwind.dart';` is not present, add it after the existing `import 'package:flutter/material.dart';` line.

- [ ] **Step 5: Verify file analyzes clean**

```bash
flutter analyze lib/src/base/size_builder.dart 2>&1 | tail -3
```

Expected: clean or only pre-existing info-level lints unrelated to this change.

- [ ] **Step 6: Commit**

```bash
git add lib/src/base/size_builder.dart
git commit -m "refactor: size_builder reads screenW/H from Tailwind cache

_screenH/_screenW no longer call ScreenUtil().screenHeight/Width.
They read Tailwind.instance.screenH/W instead, asserting > 0 in
debug mode (so users who forget to call init() get a clear error).
Release mode falls back to 0 so the failure is visible in the UI
rather than crashing the app."
```

---

### Task 4: Fix `image_loader.pixelRatio` to use MediaQuery

**Files:**
- Modify: `lib/src/image_loader/image_loader.dart:322`

**Spec references:** § 6.2

- [ ] **Step 1: Locate the line**

```bash
grep -n "ScreenUtil().pixelRatio" lib/src/image_loader/image_loader.dart
```

Expected: one match around line 322.

- [ ] **Step 2: Replace the call**

In `lib/src/image_loader/image_loader.dart`, change:

```dart
_devicePixelRatio = _devicePixelRatio ?? ScreenUtil().pixelRatio;
```

to:

```dart
_devicePixelRatio = _devicePixelRatio ?? MediaQuery.of(context).devicePixelRatio;
```

The surrounding `build(BuildContext context)` method already has `context` in scope — no signature change needed.

- [ ] **Step 3: Remove the screenutil import if present**

```bash
grep -n "flutter_screenutil" lib/src/image_loader/image_loader.dart
```

If a line exists, delete it.

- [ ] **Step 4: Verify file analyzes clean**

```bash
flutter analyze lib/src/image_loader/image_loader.dart 2>&1 | tail -3
```

Expected: clean OR only the existing `must_be_immutable` warning on `ImageLoader` (pre-existing, unrelated).

- [ ] **Step 5: Commit**

```bash
git add lib/src/image_loader/image_loader.dart
git commit -m "refactor: image_loader uses MediaQuery for devicePixelRatio

build() has the BuildContext in scope; there's no need to route
through Tailwind.instance for this one read. MediaQuery returns
the live value, so rotation/window resize stay accurate."
```

---

### Task 5: Fix `widgets.dart` `p16/p20` + remove screenutil import

**Files:**
- Modify: `lib/src/widgets/child/widgets.dart:4-7`

**Spec references:** § 6.3

- [ ] **Step 1: Inspect the current top of the file**

```bash
sed -n '1,15p' lib/src/widgets/child/widgets.dart
```

Expected: shows the `import 'package:flutter_screenutil/...'` line and `EdgeInsetsGeometry p16 = REdgeInsets.all(16);` etc.

- [ ] **Step 2: Replace the top of the file**

Edit `lib/src/widgets/child/widgets.dart`. Remove the `import 'package:flutter_screenutil/flutter_screenutil.dart';` line. Replace the two `p16` / `p20` variable declarations with getters:

```dart
EdgeInsetsGeometry get p16 {
  final r = Tailwind.instance.sizeAdapter.r(16);
  return EdgeInsets.all(r);
}

EdgeInsetsGeometry get p20 {
  final r = Tailwind.instance.sizeAdapter.r(20);
  return EdgeInsets.all(r);
}
```

- [ ] **Step 3: Add Tailwind import**

After the remaining `import 'package:flutter/rendering.dart';`, add:

```dart
import 'package:flutter_tailwind/src/tailwind.dart';
```

- [ ] **Step 4: Verify**

```bash
grep -n "flutter_screenutil\|ScreenUtil\|REdgeInsets" lib/src/widgets/child/widgets.dart
```

Expected: no matches.

```bash
flutter analyze lib/src/widgets/child/widgets.dart 2>&1 | tail -3
```

Expected: clean.

- [ ] **Step 5: Run full library analyze — should now be GREEN**

```bash
flutter analyze lib/ test/ 2>&1 | tail -3
```

Expected: 6 issues (the same pre-existing info-level lints from v1.8.0 — `unnecessary_import` × 3, `omit_local_variable_types` × 1, `prefer_single_quotes` × 1, `must_be_immutable` × 1). **Zero new errors.** If there ARE new errors, stop and investigate.

- [ ] **Step 6: Confirm no screenutil references remain in lib/**

```bash
grep -rnE "flutter_screenutil|ScreenUtil\(\)|REdgeInsets" lib/
```

Expected: zero matches. lib is fully decoupled from screenutil.

- [ ] **Step 7: Commit**

```bash
git add lib/src/widgets/child/widgets.dart
git commit -m "refactor: widgets.dart p16/p20 become getters routing through SizeAdapter

p16/p20 were top-level final variables initialized to REdgeInsets.all(N).
Now they're top-level getters that route N through the active SizeAdapter
each time they're read. User call syntax (e.g. \`padding: p16\`) is
unchanged.

This is the last screenutil reference in lib/. After this commit,
\`grep -rE 'flutter_screenutil|ScreenUtil|REdgeInsets' lib/\` returns
zero matches."
```

---

## Phase 2: Thread adapter through builder fields

Each task below picks one builder field group, writes a widget test that proves the adapter is being called, then changes the producing code to call the adapter. End-to-end TDD using a `Mock2xAdapter` that doubles every value.

A shared test helper (`Mock2xAdapter`) lives in `test/size_adapter_test.dart` and is added in the first task of this phase. Later tasks reuse it.

### Task 6: Thread `width/height/size` through Container

**Files:**
- Modify: `lib/src/widgets/container/container.dart` (the `mk` getter at line ~206 and the `child(Widget)` method at line ~244)
- Test: `test/size_adapter_test.dart` (extend)

**Spec references:** § 5 mapping table — Container width → `sw(v)`, height → `sh(v)`, size → `sr(v)`

- [ ] **Step 1: Add Mock2xAdapter to the test file**

Append to `test/size_adapter_test.dart` (above the `void main()` line — or at the top):

```dart
/// Reusable test double: every value is doubled.
/// Used across size_adapter tests to verify the adapter is in the read path.
class Mock2xAdapter implements SizeAdapter {
  const Mock2xAdapter();
  @override double w(double v) => v * 2;
  @override double h(double v) => v * 2;
  @override double r(double v) => v * 2;
  @override double sp(double v) => v * 2;
}

void resetAdapter() {
  Tailwind.instance.sizeAdapter = const IdentitySizeAdapter();
}
```

- [ ] **Step 2: Write the failing test (container width threads through adapter)**

Append to `test/size_adapter_test.dart`, inside `void main()`:

```dart
import 'package:flutter/material.dart';
// ^ if not already imported at top
```

Then inside `main()`:

```dart
group('Container threads geometry through adapter', () {
  setUp(resetAdapter);

  testWidgets('width uses adapter.w', (tester) async {
    Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
    await tester.pumpWidget(MaterialApp(
      home: container.w200.red.child(const SizedBox()),
    ));
    final c = tester.widget<Container>(find.byType(Container).first);
    expect(c.constraints?.maxWidth, 400.0,
        reason: 'Mock2xAdapter should double 200 to 400');
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
```

- [ ] **Step 3: Run test to verify failure**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -10
```

Expected: the 3 new tests fail — container produces width 200 / height 100 / size 50 (raw), not 400 / 200 / 100. (The Identity tests from Task 1 still pass.)

- [ ] **Step 4: Update the two `Container`-constructing sites in container.dart**

In `lib/src/widgets/container/container.dart`, the file has TWO places that read width/height/size: the `Widget get mk` method (~line 206) and the `Widget child(Widget child)` method (~line 244). Both end up calling `Container(width: ..., height: ..., ...)`. In each, change:

```dart
Container(
  ...
  width: width ?? size,
  height: height ?? size,
  ...
)
```

to:

```dart
Container(
  ...
  width: width != null ? sw(width!) : (size != null ? sr(size!) : null),
  height: height != null ? sh(height!) : (size != null ? sr(size!) : null),
  ...
)
```

(Two edits — once in `mk`, once in `child`.)

- [ ] **Step 5: Add the helpers import if missing**

```bash
grep -n "size_adapter" lib/src/widgets/container/container.dart
```

If absent, add to the imports near the top:

```dart
import 'package:flutter_tailwind/src/adapters/size_adapter.dart';
```

- [ ] **Step 6: Run tests to verify pass**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -10
```

Expected: all tests pass (the 4 Identity tests from Task 1 + the 3 new Container tests).

- [ ] **Step 7: Commit**

```bash
git add lib/src/widgets/container/container.dart test/size_adapter_test.dart
git commit -m "feat: Container threads width/height/size through SizeAdapter

ContainerBuilder.mk and ContainerBuilder.child both wrap their
width/height/size reads in sw/sh/sr helpers. Widget tests with a
Mock2xAdapter confirm the adapter is in the read path: container.w200
under the mock produces Container width=400."
```

---

### Task 7: Thread padding through `PaddingBuilder.finalPadding`

**Files:**
- Modify: `lib/src/base/padding_builder.dart` — the `finalPadding` getter (line ~41)
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — padding 4 sides → `sr(v)`

- [ ] **Step 1: Write failing test**

Append to `test/size_adapter_test.dart` inside `main()`:

```dart
group('PaddingBuilder threads through adapter.r', () {
  setUp(resetAdapter);

  testWidgets('container.p16 doubles padding under mock', (tester) async {
    Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
    await tester.pumpWidget(MaterialApp(
      home: container.red.p16.child(const SizedBox()),
    ));
    final c = tester.widget<Container>(find.byType(Container).first);
    expect(c.padding, const EdgeInsets.all(32.0),
        reason: 'p16 should pass 16 through adapter.r → 32');
  });
});
```

- [ ] **Step 2: Run test to verify failure**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

Expected: new test fails — padding is 16, not 32.

- [ ] **Step 3: Update `finalPadding` getter**

In `lib/src/base/padding_builder.dart`, change the `finalPadding` getter from:

```dart
EdgeInsetsGeometry? get finalPadding {
  if (_innerPadding != null) return _innerPadding;
  if (hasPadding) {
    return EdgeInsets.only(
      left: paddingLeft ?? paddingHorizontal ?? paddingValue ?? 0.0,
      right: paddingRight ?? paddingHorizontal ?? paddingValue ?? 0.0,
      top: paddingTop ?? paddingVertical ?? paddingValue ?? 0.0,
      bottom: paddingBottom ?? paddingVertical ?? paddingValue ?? 0.0,
    );
  }
  return null;
}
```

to:

```dart
EdgeInsetsGeometry? get finalPadding {
  if (_innerPadding != null) return _innerPadding;
  if (hasPadding) {
    return EdgeInsets.only(
      left: sr(paddingLeft ?? paddingHorizontal ?? paddingValue ?? 0.0),
      right: sr(paddingRight ?? paddingHorizontal ?? paddingValue ?? 0.0),
      top: sr(paddingTop ?? paddingVertical ?? paddingValue ?? 0.0),
      bottom: sr(paddingBottom ?? paddingVertical ?? paddingValue ?? 0.0),
    );
  }
  return null;
}
```

Add the helpers import at the top of the file if missing:

```dart
import 'package:flutter_tailwind/src/adapters/size_adapter.dart';
```

- [ ] **Step 4: Run test**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

Expected: all tests pass.

- [ ] **Step 5: Commit**

```bash
git add lib/src/base/padding_builder.dart test/size_adapter_test.dart
git commit -m "feat: PaddingBuilder.finalPadding routes 4 sides through sr()

All 4 sides of EdgeInsets.only go through the adapter's r channel.
container.p16 under Mock2xAdapter now produces EdgeInsets.all(32)."
```

---

### Task 8: Thread margin through `MarginBuilder.finalMargin`

**Files:**
- Modify: `lib/src/base/margin_builder.dart` — the `finalMargin` getter (parallel structure to Task 7)
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — margin 4 sides → `sr(v)`

- [ ] **Step 1: Locate `finalMargin`**

```bash
grep -n "finalMargin\|get finalMargin\|EdgeInsets.only" lib/src/base/margin_builder.dart | head -10
```

Note the structure — it should mirror `finalPadding`.

- [ ] **Step 2: Write failing test**

Append to `test/size_adapter_test.dart`:

```dart
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
```

- [ ] **Step 3: Run, expect failure**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

- [ ] **Step 4: Apply the same `sr(...)` wrapping to `finalMargin`**

Open `lib/src/base/margin_builder.dart`, find the `finalMargin` getter (it constructs an `EdgeInsets.only(left: ..., right: ..., top: ..., bottom: ...)` very similarly to `finalPadding`), and wrap each of the 4 side values in `sr(...)` — mirror Task 7 step 3 exactly.

Add the import `import 'package:flutter_tailwind/src/adapters/size_adapter.dart';` if missing.

- [ ] **Step 5: Run, expect pass**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

- [ ] **Step 6: Commit**

```bash
git add lib/src/base/margin_builder.dart test/size_adapter_test.dart
git commit -m "feat: MarginBuilder.finalMargin routes 4 sides through sr()"
```

---

### Task 9: Thread border-radius through `BorderRadiusBuilder`

**Files:**
- Modify: `lib/src/base/border_radius_builder.dart` — wherever the radius is materialized into `BorderRadius.circular(...)` or similar
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — radius → `sr(v)`

- [ ] **Step 1: Find where the radius value is consumed**

```bash
grep -n "BorderRadius\.\|borderRadius\b" lib/src/base/border_radius_builder.dart | head -10
```

Look for getters or methods that take stored radius values and produce a `BorderRadiusGeometry`. There may be a single `borderRadius` getter that builds the final value.

- [ ] **Step 2: Write failing test**

Append to `test/size_adapter_test.dart`:

```dart
group('BorderRadiusBuilder threads through adapter.r', () {
  setUp(resetAdapter);

  testWidgets('container.rounded8 doubles radius under mock', (tester) async {
    Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
    await tester.pumpWidget(MaterialApp(
      home: container.red.rounded8.child(const SizedBox()),
    ));
    final c = tester.widget<Container>(find.byType(Container).first);
    final deco = c.decoration as BoxDecoration;
    final br = deco.borderRadius as BorderRadius;
    expect(br.topLeft.x, 16.0,
        reason: 'rounded8 should pass 8 through adapter.r → 16');
  });
});
```

- [ ] **Step 3: Run, expect failure**

- [ ] **Step 4: Wrap radius values in `sr(...)`**

In `lib/src/base/border_radius_builder.dart`, find the place where the stored radius values are read and turned into a `BorderRadius`. Wrap each scalar in `sr(...)`. Common patterns to expect:

```dart
// Before
return BorderRadius.only(
  topLeft: Radius.circular(topLeftRadius ?? 0),
  ...
);

// After
return BorderRadius.only(
  topLeft: Radius.circular(sr(topLeftRadius ?? 0)),
  ...
);
```

OR if there's a single-value `BorderRadius.circular(radiusValue)`:

```dart
// Before
return BorderRadius.circular(radiusValue ?? 0);
// After
return BorderRadius.circular(sr(radiusValue ?? 0));
```

Add `import 'package:flutter_tailwind/src/adapters/size_adapter.dart';` if missing.

- [ ] **Step 5: Run, expect pass**

- [ ] **Step 6: Commit**

```bash
git add lib/src/base/border_radius_builder.dart test/size_adapter_test.dart
git commit -m "feat: BorderRadiusBuilder routes radius through sr()"
```

---

### Task 10: Thread positioning through `PositionedBuilder`

**Files:**
- Modify: `lib/src/base/positioned_builder.dart` AND/OR `lib/src/widgets/child/positioned.dart` (whichever constructs `Positioned(...)`)
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — left/right/top/bottom → `sr(v)`

- [ ] **Step 1: Find where Positioned is constructed**

```bash
grep -rn "Positioned(\|Positioned\." lib/src/widgets/child/positioned.dart lib/src/base/positioned_builder.dart
```

- [ ] **Step 2: Write failing test**

Append to `test/size_adapter_test.dart`:

```dart
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
    expect(p.left, 32.0, reason: 'l16 → sr(16) → 32');
    expect(p.top, 16.0, reason: 't8 → sr(8) → 16');
  });
});
```

- [ ] **Step 3: Run, expect failure**

- [ ] **Step 4: Wrap left/right/top/bottom in `sr(...)`**

At the `Positioned(...)` construction site:

```dart
// Before
return Positioned(
  left: leftValue,
  right: rightValue,
  top: topValue,
  bottom: bottomValue,
  child: child,
);

// After (wrap non-null values only)
return Positioned(
  left: leftValue != null ? sr(leftValue!) : null,
  right: rightValue != null ? sr(rightValue!) : null,
  top: topValue != null ? sr(topValue!) : null,
  bottom: bottomValue != null ? sr(bottomValue!) : null,
  child: child,
);
```

Add the size_adapter import if missing.

- [ ] **Step 5: Run, expect pass**

- [ ] **Step 6: Commit**

```bash
git add lib/src/widgets/child/positioned.dart lib/src/base/positioned_builder.dart test/size_adapter_test.dart
git commit -m "feat: PositionedBuilder routes l/r/t/b through sr()"
```

---

### Task 11: Thread shadow values through `ShadowBuilder`

**Files:**
- Modify: `lib/src/base/shadow_builder.dart` — where `BoxShadow(...)` is constructed
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — blurRadius / spreadRadius / offset → `sr(v)`

- [ ] **Step 1: Read the file to find the BoxShadow construction**

```bash
sed -n '1,80p' lib/src/base/shadow_builder.dart
```

- [ ] **Step 2: Write failing test**

Append to `test/size_adapter_test.dart`:

```dart
group('ShadowBuilder threads through adapter.r', () {
  setUp(resetAdapter);

  testWidgets('container.shadow doubles blur/offset under mock', (tester) async {
    Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
    await tester.pumpWidget(MaterialApp(
      home: container.red.shadow.child(const SizedBox()),
    ));
    final c = tester.widget<Container>(find.byType(Container).first);
    final deco = c.decoration as BoxDecoration;
    final shadow = deco.boxShadow!.first;
    // The spec defines `shadow` (single) as a fixed preset. We're proving
    // the values are MULTIPLIED by 2 vs identity, so any non-zero baseline
    // value confirms adapter.r is in the path.
    expect(shadow.blurRadius % 2, 0,
        reason: 'blurRadius should be even (doubled from integer baseline)');
  });
});
```

(The exact baseline blur depends on what `.shadow` is defined as. The "× 2" smoke test above just checks adapter is in the path. If `.shadow` baseline is fractional, replace the test with a specific expectation after Step 4.)

- [ ] **Step 3: Run, expect failure** (baseline likely odd if adapter not in path)

- [ ] **Step 4: Wrap shadow scalars in `sr(...)`**

At `BoxShadow(...)` construction in `shadow_builder.dart`, wrap `blurRadius`, `spreadRadius`, and `offset.dx`/`offset.dy` in `sr(...)`:

```dart
// Before
BoxShadow(
  color: ...,
  blurRadius: blurValue,
  spreadRadius: spreadValue,
  offset: Offset(dx, dy),
)

// After
BoxShadow(
  color: ...,
  blurRadius: sr(blurValue),
  spreadRadius: sr(spreadValue),
  offset: Offset(sr(dx), sr(dy)),
)
```

Add size_adapter import.

- [ ] **Step 5: Run, expect pass; tune the test expectation to the actual exact value if the smoke test isn't precise enough**

- [ ] **Step 6: Commit**

```bash
git add lib/src/base/shadow_builder.dart test/size_adapter_test.dart
git commit -m "feat: ShadowBuilder routes blur/spread/offset through sr()"
```

---

### Task 12: Thread spacing through `SpacingBuilder` consumers (Row/Column/Wrap/GridView)

**Files:**
- Modify: `lib/src/base/spacing_builder.dart` if it has a `finalSpacing`/`computedSpacing` getter; OR the consumers (`children_container.dart`, `wrap.dart`, `list_view.dart`)
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — `spacing` → `sr(v)`

- [ ] **Step 1: Find where stored spacing is consumed**

```bash
grep -n "innerSpacing\|spacing:" lib/src/base/spacing_builder.dart lib/src/widgets/container/children_container.dart lib/src/widgets/child/wrap.dart lib/src/widgets/container/list_view.dart | head -20
```

- [ ] **Step 2: Write failing test**

```dart
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
    final col = tester.widget<Column>(find.byType(Column));
    expect(col.spacing, 32.0, reason: 'spacing16 → sr(16) → 32');
  });
});
```

(Note: Flutter's `Column.spacing` is the underlying property used by Flutter 3.27+. If the library's wrapper uses a different mechanism (e.g. SizedBox separators), adjust the test accordingly — read `column.spacing16.children([...])` source to know what to assert.)

- [ ] **Step 3: Run, expect failure**

- [ ] **Step 4: Wrap each consumer's spacing read in `sr(...)`**

The change might land in 4 separate consumer files (Row, Column, Stack via children_container, Wrap, GridView via list_view). Each wraps the stored `innerSpacing` value at the point of constructing the underlying Flutter widget:

```dart
// Before
Column(spacing: innerSpacing ?? 0, children: children)
// After
Column(spacing: sr(innerSpacing ?? 0), children: children)
```

Add the size_adapter import to each consumer file modified.

- [ ] **Step 5: Run all tests, expect pass**

- [ ] **Step 6: Commit**

```bash
git add lib/src/base/spacing_builder.dart lib/src/widgets/container/children_container.dart lib/src/widgets/child/wrap.dart lib/src/widgets/container/list_view.dart test/size_adapter_test.dart
git commit -m "feat: spacing-property consumers route through sr()

Row/Column/Stack/Wrap/GridView all wrap the stored spacing value in
sr() at construction time. column.spacing16 under Mock2xAdapter
produces Column(spacing: 32)."
```

---

### Task 13: Thread `fontSize` through TextBuilder (and its `_style` builder)

**Files:**
- Modify: `lib/src/widgets/child/text.dart` (the `_style` getter and/or where `TextStyle(fontSize: ...)` is constructed)
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — fontSize → `ssp(v)`

- [ ] **Step 1: Find where fontSize is consumed into a TextStyle**

```bash
grep -n "fontSize\|TextStyle\b\|_style" lib/src/widgets/child/text.dart | head -15
```

Look for the getter that builds the final `TextStyle` (called `_style` in spec).

- [ ] **Step 2: Write failing test**

```dart
group('FontSizeBuilder threads through adapter.sp', () {
  setUp(resetAdapter);

  testWidgets("'hello'.text.f16 doubles fontSize under mock", (tester) async {
    Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
    await tester.pumpWidget(MaterialApp(
      home: 'hello'.text.f16.bold.mk,
    ));
    final t = tester.widget<Text>(find.text('hello'));
    expect(t.style?.fontSize, 32.0, reason: 'f16 → ssp(16) → 32');
  });
});
```

- [ ] **Step 3: Run, expect failure**

- [ ] **Step 4: Wrap fontSize in `ssp(...)`**

In `lib/src/widgets/child/text.dart`, find the `_style` getter or wherever `fontSize:` appears in a `TextStyle` constructor. Wrap the value in `ssp(...)`:

```dart
// Before
TextStyle(
  fontSize: fontSize,
  ...
)

// After
TextStyle(
  fontSize: fontSize != null ? ssp(fontSize!) : null,
  ...
)
```

If the library has an AutoSizeText branch (it does — see `_useAutoSize` in `mk`), confirm the `minFontSize` passed to AutoSizeText is also routed through `ssp(...)`:

```dart
// Before
final minFontSize = min(fontSizes![0], fontSizes![1]).round().toDouble();
// After
final minFontSize = ssp(min(fontSizes![0], fontSizes![1]).round().toDouble());
```

Add size_adapter import.

- [ ] **Step 5: Run, expect pass**

- [ ] **Step 6: Commit**

```bash
git add lib/src/widgets/child/text.dart test/size_adapter_test.dart
git commit -m "feat: TextBuilder routes fontSize through ssp()

Single-size Text and AutoSizeText both wrap fontSize values through
the adapter's sp channel. 'hello'.text.f16.mk under Mock2xAdapter
produces Text(style: TextStyle(fontSize: 32))."
```

---

### Task 14: Thread `width/height/size` in other geometry-bearing builders (sized_box, image, svg, icon)

**Files:**
- Modify: `lib/src/widgets/child/sized_box.dart`
- Modify: `lib/src/widgets/child/image.dart`
- Modify: `lib/src/widgets/child/svg.dart`
- Modify: `lib/src/widgets/child/icon.dart`
- Test: `test/size_adapter_test.dart`

**Spec references:** § 5 mapping — width → `sw`, height → `sh`, size → `sr`

- [ ] **Step 1: Read each file's `mk` to find geometry reads**

```bash
for f in sized_box image svg icon; do
  echo "=== $f.dart ==="
  grep -n "width\|height\|size\b" lib/src/widgets/child/$f.dart | head -8
done
```

- [ ] **Step 2: Write a failing test per builder**

Append a single condensed test block to `test/size_adapter_test.dart`:

```dart
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

  // image / svg tests would require network/svg loading harnesses;
  // they're omitted here and covered by manual smoke testing during
  // doc rewrites in Phase 3.
});
```

- [ ] **Step 3: Run, expect failure**

- [ ] **Step 4: Apply the `sw/sh/sr` wrapping pattern in each builder's `mk`**

For each of `sized_box.dart`, `image.dart`, `svg.dart`, `icon.dart`:

- `width` field → `sw(width!)` at the construction site
- `height` field → `sh(height!)` at the construction site
- `size` field → `sr(size!)` at the construction site (used by icon, square sizes for image/svg)

Add the size_adapter import to each file. The exact construction site varies — for SizedBox it's the `SizedBox(width: ..., height: ...)` constructor; for Icon it's `Icon(..., size: ...)`; etc.

- [ ] **Step 5: Run, expect pass**

- [ ] **Step 6: Commit**

```bash
git add lib/src/widgets/child/sized_box.dart lib/src/widgets/child/image.dart lib/src/widgets/child/svg.dart lib/src/widgets/child/icon.dart test/size_adapter_test.dart
git commit -m "feat: sized_box / image / svg / icon thread geometry through adapter"
```

---

### Task 15: Audit-sweep for any remaining un-adapted geometry/font values

A defensive task to catch anything Phase 2 missed. The goal: every numeric value in any `Container/SizedBox/Padding/EdgeInsets/BoxDecoration/BorderRadius/BoxShadow/TextStyle` constructor in `lib/` either:
- Goes through `sw/sh/sr/ssp`, OR
- Is intentionally raw (a literal `0`, a constant like `Spacer`'s `flex`, an opacity 0–1, or a BorderWidth — see spec § 5 "不调" rows)

- [ ] **Step 1: List every constructor call that takes numeric geometry**

```bash
cd /Users/barry/Code/github/flutter_tailwind
grep -rnE "EdgeInsets\.|BorderRadius\.|BoxShadow\(|TextStyle\(|SizedBox\(|Container\(|Positioned\(" lib/src/ | grep -v "// " | head -40
```

- [ ] **Step 2: For each match, verify it either uses `sr/sw/sh/ssp` OR is intentionally raw**

This is a manual eyeball pass. For each line, ask: "Is the numeric value here a user-supplied geometry value that should scale?" If yes and it's not wrapped → fix. If no (e.g. `EdgeInsets.zero`, `BorderRadius.zero`, hairline `width: 1`, opacity values) → leave alone.

If new wrappings are needed, add a test for that path first (TDD), then make the change. Add to `test/size_adapter_test.dart` and commit per builder.

- [ ] **Step 3: Final full library analyze + test run**

```bash
flutter analyze lib/ test/ 2>&1 | tail -3
flutter test test/ 2>&1 | tail -5
```

Expected:
- `flutter analyze`: 6 issues (pre-existing info-level lints, see Task 5 step 5)
- `flutter test`: all tests pass

- [ ] **Step 4: Commit (only if anything was found in Step 2)**

```bash
git add -p
git commit -m "feat: catch remaining un-adapted geometry sites in lib/

Audit sweep after Phase 2 — wraps <N> additional construction sites
identified by greping for raw EdgeInsets/BorderRadius/TextStyle
constructors in lib/src/."
```

If nothing was found, no commit — move to Task 16.

---

### Task 16: Flesh out `test/size_adapter_test.dart` with adapter-swap + reset behavior

**Files:**
- Modify: `test/size_adapter_test.dart`

The test file already has many specific tests from Phase 2. Add the remaining coverage from spec § 8.1.

- [ ] **Step 1: Add "adapter swap takes effect immediately" test**

Append to `test/size_adapter_test.dart`:

```dart
group('adapter swap behavior', () {
  setUp(resetAdapter);

  testWidgets('switching adapter mid-test affects subsequent mk calls', (tester) async {
    // First adapter — identity
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
```

- [ ] **Step 2: Run all tests, expect pass**

```bash
flutter test test/size_adapter_test.dart 2>&1 | tail -5
```

- [ ] **Step 3: Commit**

```bash
git add test/size_adapter_test.dart
git commit -m "test: cover adapter-swap behavior in size_adapter_test"
```

---

### Task 17: Rewrite `tailwind_primary_test.dart` → `tailwind_init_test.dart`

**Files:**
- Rename / Replace: `test/tailwind_primary_test.dart` → `test/tailwind_init_test.dart`

The v1.8 test file used `Tailwind.instance.context` (a field we just removed). The whole file needs rewriting for v2.0 semantics. Spec § 8.2 lists the test cases.

- [ ] **Step 1: Delete the old file**

```bash
git rm test/tailwind_primary_test.dart
```

- [ ] **Step 2: Create the new file**

Write `test/tailwind_init_test.dart`:

```dart
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
```

- [ ] **Step 3: Run the test**

```bash
flutter test test/tailwind_init_test.dart 2>&1 | tail -10
```

Expected: all 8 tests pass.

- [ ] **Step 4: Run the full test suite**

```bash
flutter test 2>&1 | tail -5
```

Expected: all tests pass (`size_adapter_test.dart` from Phase 2 + new `tailwind_init_test.dart`).

- [ ] **Step 5: Commit**

```bash
git add test/tailwind_init_test.dart
git commit -m "test: replace tailwind_primary_test with tailwind_init_test for v2.0

The v1.8 tests poked Tailwind.instance.context (now removed). New
file covers:
- primary-color fallback when not initialized
- init() populates screenW/screenH/primaryColor from MediaQuery+Theme
- init's fallbackPrimary overrides Theme value
- hFull asserts when accessed without init (debug)
- hFull works correctly after init"
```

---

## Phase 3: Docs

### Task 18: Rewrite `doc/getting-started.md`

**Files:**
- Modify: `doc/getting-started.md`

Replace the v1.8 init / opt-in-adaptW guidance with v2.0 SizeAdapter guidance. The new file should cover:
1. Install (unchanged)
2. Bare-minimum usage (unchanged — defaults still work)
3. Adding screen scaling via SizeAdapter (NEW — was "ScreenUtilInit wrap" before)
4. Setting up primary color (unchanged in user-facing API; just verify init position guidance is intact)

- [ ] **Step 1: Replace the "Adding screen adaptation" section**

Open `doc/getting-started.md`. Find the section that talks about `ScreenUtilInit` wrapping + `.adaptW/.adaptH/.adaptR/.adaptSp` (around the middle of the file). Replace it with:

```markdown
## Adding screen adaptation (optional, opt-in via SizeAdapter)

By default the library does no scaling — `container.w200.mk` produces `Container(width: 200)` literal pixels on every device.

To enable scaling, write a 4-line `SizeAdapter` and install it once at app startup. Example wrapping `flutter_screenutil`:

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();
  @override double w(double v) => v.w;
  @override double h(double v) => v.h;
  @override double r(double v) => v.r;
  @override double sp(double v) => v.sp;
}

void main() {
  Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
  runApp(const MyApp());
}
```

Same pattern works for `responsive_framework`, `sizer`, or any custom solution — implement the 4 methods to call your scaling library, install via `configSizeAdapter`.

The 4 channels (`w/h/r/sp`) correspond to width / height / responsive (radius / padding / shadow) / font-size. Your adapter decides how each maps to your library's scaling functions.

> **Migrating from v1.x?** The per-call `.adaptW/.adaptH/.adaptR/.adaptSp` getters are gone in v2.0 — they're replaced by this single global config. See `CHANGELOG.md` for the migration steps.
```

- [ ] **Step 2: Verify the init-position section is still correct**

Search the file for `init(`:

```bash
grep -n "Tailwind.instance.init\|MaterialApp.builder\|ScreenUtilInit.builder" doc/getting-started.md
```

The init-position guidance (init must be inside MaterialApp) was added in v1.8 and stays valid. Confirm the existing ❌ / ✅ counter-example block is intact. If it's missing, add it back per spec § 4.5.

- [ ] **Step 3: Commit**

```bash
git add doc/getting-started.md
git commit -m "doc: rewrite getting-started — SizeAdapter replaces .adaptW/H/R/Sp"
```

---

### Task 19: Rewrite `doc/patterns/screen-adaptation.md`

**Files:**
- Replace: `doc/patterns/screen-adaptation.md`

The whole file documented `.adaptW/.adaptH/.adaptR/.adaptSp`. Those getters are gone — rewrite top-to-bottom.

- [ ] **Step 1: Replace the file entirely**

Overwrite `doc/patterns/screen-adaptation.md`:

```markdown
# Screen Adaptation: SizeAdapter

> **Status:** v2.0 introduces `SizeAdapter` as the single point of screen-scaling configuration. The per-call `.adaptW/.adaptH/.adaptR/.adaptSp` getters from v1.7.x/v1.8.x are removed.

## Default: no scaling

Out of the box, `flutter_tailwind` does not scale any values:

```dart
container.w200.h100.p16.red.mk
// Container(width: 200, height: 100, padding: EdgeInsets.all(16), ...)
// Literal logical pixels on every device.
```

If you don't need responsive sizing, you're done. Stop reading.

## Enabling scaling: implement SizeAdapter

`SizeAdapter` has 4 methods, one per scaling channel:

| Method | Used for | Typical screenutil mapping |
|---|---|---|
| `w(v)` | Widths | `v.w` |
| `h(v)` | Heights | `v.h` |
| `r(v)` | Responsive — radii, padding, margin, position, shadow | `v.r` |
| `sp(v)` | Font sizes | `v.sp` |

Write a class implementing it and inject via `Tailwind.instance.configSizeAdapter(...)`.

### Example: flutter_screenutil

```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();
  @override double w(double v) => v.w;
  @override double h(double v) => v.h;
  @override double r(double v) => v.r;
  @override double sp(double v) => v.sp;
}

void main() {
  Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
  runApp(const MyApp());
}
```

You still need to wrap your app in `ScreenUtilInit` (screenutil's own setup); the adapter just teaches `flutter_tailwind` to call screenutil's scaling functions.

### Example: responsive_framework (sketch)

```dart
class ResponsiveSizeAdapter implements SizeAdapter {
  ResponsiveSizeAdapter(this.scalingFactor);
  final double scalingFactor;
  @override double w(double v) => v * scalingFactor;
  @override double h(double v) => v * scalingFactor;
  @override double r(double v) => v * scalingFactor;
  @override double sp(double v) => v * scalingFactor; // or different factor for fonts
}
```

Whatever your scaling story is, you implement those 4 methods however you want.

## When to use each channel

- `r(v)` is the catch-all "responsive value" channel for things that don't fit cleanly into width or height (radii, paddings, shadows). Most builder values route through here.
- `w(v)` and `h(v)` are direction-specific scaling for Container width/height fields.
- `sp(v)` handles fonts specifically — kept separate because font scaling often considers system `textScaleFactor`, which geometric scaling does not.

## What if I don't configure an adapter?

The library defaults to `IdentitySizeAdapter`:

```dart
class IdentitySizeAdapter implements SizeAdapter {
  const IdentitySizeAdapter();
  @override double w(double v) => v;
  @override double h(double v) => v;
  @override double r(double v) => v;
  @override double sp(double v) => v;
}
```

Every value passes through unchanged. Safe default for projects that prefer literal pixel sizing.

## Migration from v1.x

If your v1.x/v1.8 code looks like:

```dart
container.w200.adaptW.h100.adaptH.p16.adaptR.child(text.f16.adaptSp.mk)
```

In v2.0:

1. Remove every `.adaptW/.adaptH/.adaptR/.adaptSp` call from your code.
2. Add an adapter (see flutter_screenutil example above) once in `main()`.

After this, the library calls the adapter automatically — no per-call opt-in needed.

## Not under SizeAdapter's control

The library deliberately does NOT scale:

- **Border width** — hairline borders should stay 1 logical pixel on every device.
- **`expanded` flex values** — they're ints, not pixel measurements.
- **`opacity`** — a 0-to-1 ratio, not a size.
- **`hFull/wFull/sScreen/sFull` family** — these read absolute screen dimensions from `Tailwind.instance.screenW/screenH` (cached at `init(context)`). They are screen-percentages and don't need adapter scaling.
```

- [ ] **Step 2: Commit**

```bash
git add doc/patterns/screen-adaptation.md
git commit -m "doc: rewrite screen-adaptation.md for v2.0 SizeAdapter API

Removes the .adaptW/.adaptH/.adaptR/.adaptSp documentation and
replaces it with the SizeAdapter setup story:
- default IdentitySizeAdapter (no scaling)
- 4-line ScreenUtilSizeAdapter copy-paste template
- responsive_framework example sketch
- channel semantics (w/h/r/sp)
- migration steps from v1.x"
```

---

### Task 20: Update `.cursor/rules/flutter_tailwind.mdc`

**Files:**
- Modify: `.cursor/rules/flutter_tailwind.mdc`

- [ ] **Step 1: Find and update the screen-adaptation section**

```bash
grep -n "adaptW\|adaptH\|adaptR\|adaptSp\|ScreenUtilInit" .cursor/rules/flutter_tailwind.mdc | head -10
```

Edit those sections. The simplest approach: replace any block teaching `.adaptW/.adaptH/.adaptR/.adaptSp` with a pointer + a brief restated version of Task 19's content. Keep it under ~50 lines in cursor rules.

Example replacement block:

```markdown
### 屏幕适配（v2.0+）

通过 `SizeAdapter` 全局配置，不再使用 `.adaptW/.adaptH/.adaptR/.adaptSp`（v2.0 已删）。

```dart
class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();
  @override double w(double v) => v.w;
  @override double h(double v) => v.h;
  @override double r(double v) => v.r;
  @override double sp(double v) => v.sp;
}

void main() {
  Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
  runApp(...);
}
```

默认 `IdentitySizeAdapter`（不缩放）。详见 `doc/patterns/screen-adaptation.md`。
```

- [ ] **Step 2: Find and remove any remaining `.adaptW/H/R/Sp` references throughout the file**

```bash
grep -n "adaptW\|adaptH\|adaptR\|adaptSp" .cursor/rules/flutter_tailwind.mdc
```

Each remaining hit needs to be updated or removed — these getters no longer exist.

- [ ] **Step 3: Commit**

```bash
git add .cursor/rules/flutter_tailwind.mdc
git commit -m "doc: cursor rules updated for v2.0 SizeAdapter

Removed all .adaptW/.adaptH/.adaptR/.adaptSp references (deleted in
v2.0). New section points at SizeAdapter with the ScreenUtilSizeAdapter
template and links the full docs."
```

---

### Task 21: Update `README.md` + `CLAUDE.md`

**Files:**
- Modify: `README.md`
- Modify: `CLAUDE.md`

- [ ] **Step 1: README.md — add SizeAdapter mention**

Open `README.md`. Near the top of the "Documentation" links section, add:

```markdown
> **Screen scaling is opt-in via `SizeAdapter`.** No scaling by default. See `doc/patterns/screen-adaptation.md` for the setup template.
```

- [ ] **Step 2: CLAUDE.md — update the Singleton config + Responsive sizing sections**

Replace the "Singleton config" paragraph with:

```markdown
### Singleton config

`Tailwind` (lib/src/tailwind.dart) is a singleton with these fields:

- `sizeAdapter: SizeAdapter` — default `IdentitySizeAdapter`. Replace via `configSizeAdapter`.
- `screenW: double` / `screenH: double` — populated at `init(context)`. Used by `hFull/wFull/sScreen/sFull` family getters.
- `primaryColor: Color?` — populated at `init(context)` from `Theme.of(context).primaryColor`, or set directly.
- `imageFactory: BaseImageFactory?` — pluggable image loader.

`init(BuildContext context, [Color? fallbackPrimary])` extracts values from context **immediately** and does NOT retain the context. Must be called with a context inside the `MaterialApp` widget tree (typically `MaterialApp.builder` or the home page's `build`).
```

Replace the "Responsive sizing" paragraph with:

```markdown
### Responsive sizing

`flutter_tailwind` v2.0 has zero dependency on `flutter_screenutil` or any other screen-adaptation library. Sizing is opt-in via `SizeAdapter` — a 4-method interface (`w/h/r/sp`) that users implement to plug in their own scaling. Default `IdentitySizeAdapter` does no scaling. The library calls `sw/sh/sr/ssp` helpers (top-level in `lib/src/adapters/size_adapter.dart`) inside builder `mk` methods to route every geometry/font value through the active adapter. See `doc/patterns/screen-adaptation.md`.
```

- [ ] **Step 3: Commit**

```bash
git add README.md CLAUDE.md
git commit -m "doc: README + CLAUDE.md updated for v2.0 SizeAdapter"
```

---

## Phase 4: Release prep

### Task 22: Bump version + write CHANGELOG entry

**Files:**
- Modify: `pubspec.yaml`
- Modify: `CHANGELOG.md`

- [ ] **Step 1: Bump pubspec version**

In `pubspec.yaml`, change:

```yaml
version: 1.8.0
```

to:

```yaml
version: 2.0.0
```

- [ ] **Step 2: Prepend CHANGELOG entry**

At the top of `CHANGELOG.md` (above the `## 1.8.0` entry), insert:

```markdown
## 2.0.0

### Breaking changes

- Removed `adaptW` / `adaptH` / `adaptR` / `adaptSp` getters. Replaced by global configuration via `Tailwind.instance.configSizeAdapter(...)`. To preserve the old behavior, write a 4-line SizeAdapter that wraps screenutil — see `doc/patterns/screen-adaptation.md`.
- Removed `flutter_screenutil` dependency. The library no longer transitively pulls screenutil. If your project relied on the indirect export (e.g. `ScreenUtilInit` imported via `package:flutter_tailwind`), add `flutter_screenutil` to your own `pubspec.yaml`.
- Removed `Tailwind.instance.context` field. `init()` now extracts needed values from the context immediately and does not retain it. `.primary` no longer needs a try-catch (the deactivated-context throw scenario cannot happen anymore).
- `p16` / `p20` are now top-level getters (were `final` variables). Calling syntax (`padding: p16`) unchanged but each access now routes through `SizeAdapter`.

### New

- `SizeAdapter` abstract class — 4-method interface (`w/h/r/sp`) that decouples the library from any specific screen-adaptation package. Default `IdentitySizeAdapter` (no scaling).
- `Tailwind.instance.screenW` / `screenH` — cached screen dimensions populated by `init(context)`. Used internally by the `hFull/wFull` family; also exposed for user code.
- `Tailwind.instance.configSizeAdapter(adapter)` — install your scaling implementation, typically once at app startup.

### Migration (1.x → 2.0)

1. Remove every `.adaptW/.adaptH/.adaptR/.adaptSp` call from your code.
2. If you used screen scaling, write a SizeAdapter subclass:
   ```dart
   class ScreenUtilSizeAdapter implements SizeAdapter {
     const ScreenUtilSizeAdapter();
     @override double w(double v) => v.w;
     @override double h(double v) => v.h;
     @override double r(double v) => v.r;
     @override double sp(double v) => v.sp;
   }
   void main() {
     Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
     runApp(...);
   }
   ```
3. If you used `hFull/wFull`-family getters, call `Tailwind.instance.init(context)` from inside `MaterialApp.builder` (or any context inside MaterialApp).

```

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml CHANGELOG.md
git commit -m "chore: bump version 1.8.0 → 2.0.0; CHANGELOG for v2.0 SizeAdapter"
```

---

### Task 23: Pre-flight checks (analyze, test, dry-run)

- [ ] **Step 1: Full analyzer pass**

```bash
flutter analyze lib/ test/ 2>&1 | tail -5
```

Expected: 6 issues, all pre-existing info-level lints (see memory `reference-publishing-to-pub-dev`). Zero new errors.

- [ ] **Step 2: Full test suite**

```bash
flutter test 2>&1 | tail -10
```

Expected: all tests pass — `size_adapter_test.dart` (~15 tests) + `tailwind_init_test.dart` (~8 tests).

- [ ] **Step 3: Pub dry-run**

```bash
flutter pub publish --dry-run 2>&1 | tail -15
```

Expected: 1 warning (the pre-existing `must_be_immutable` on `ImageLoader`). No new blocking errors. The "9 files modified in git" warning will be ZERO this time since we just committed Task 22; if it shows files modified, stage and commit them before continuing.

Verify these dry-run criteria from memory `reference-publishing-to-pub-dev`:
- [ ] `doc/` (singular) used, no `docs/` references
- [ ] `.pubignore` excludes `doc/superpowers/`
- [ ] git tree clean

If any check fails, stop and fix before Task 24.

- [ ] **Step 4: Confirm git status clean**

```bash
git status
```

Expected: "nothing to commit, working tree clean" and "Your branch is ahead of 'origin/master' by N commits".

---

### Task 24: Push + publish

The publish command is **interactive** (Google OAuth) and **irreversible** (pub.dev versions cannot be unpublished). The plan ends with the user running the actual publish command — the agent should NOT run it automatically.

- [ ] **Step 1: Push commits to origin**

```bash
git push origin master 2>&1 | tail -3
```

Expected: push succeeds. GitHub workflow `build.yml` auto-triggers (builds APK/IPA, creates dated release tag).

- [ ] **Step 2: Hand off to user for publish (manual step)**

Tell the user:

> "All commits pushed to origin. Final step is publishing to pub.dev. Run in your terminal:
> 
> ```bash
> cd /Users/barry/Code/github/flutter_tailwind
> fvm flutter packages pub publish --server=https://pub.dartlang.org
> ```
> 
> It will:
> 1. Display the package contents
> 2. Ask `Do you want to publish flutter_tailwind 2.0.0? [y/N]` — answer `y`
> 3. Prompt Google OAuth in a browser (if credentials aren't cached)
> 4. Upload to pub.dev
> 
> After it succeeds, verify with:
> 
> ```bash
> curl -s https://pub.dev/api/packages/flutter_tailwind | python3 -c 'import sys,json; print(json.load(sys.stdin)["latest"]["version"])'
> ```
> 
> Expected output: `2.0.0`"

- [ ] **Step 3: After user confirms publish succeeded, the plan is done**

---

## Self-review

(Filled in by the plan author before handing off.)

**Spec coverage:**

- § 3.1 `SizeAdapter` interface → Task 1 ✓
- § 3.2 user-side `ScreenUtilSizeAdapter` template → Tasks 19, 22 (in docs/CHANGELOG) ✓
- § 4.1 Tailwind field changes → Task 2 ✓
- § 4.2 `init` rewrite → Task 2 ✓
- § 4.3 `.primary` simplification → Task 2 ✓
- § 4.4 `configSizeAdapter` → Task 2 ✓
- § 4.5 init position guidance → Tasks 18, 19, 20, 21 (docs) ✓
- § 5 field mapping → Tasks 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ✓
- § 6.1 `_screenH/_screenW` → Task 3 ✓
- § 6.2 `image_loader.pixelRatio` → Task 4 ✓
- § 6.3 `widgets.dart p16/p20` → Task 5 ✓
- § 7 breaking-change list + migration → Task 22 (CHANGELOG) ✓
- § 8.1 size_adapter_test → Tasks 1, 6–16 ✓
- § 8.2 tailwind_init_test → Task 17 ✓
- § 8.3 test baseline non-goal → respected (only new-feature tests, not blanket coverage) ✓
- § 9 doc updates → Tasks 18–21 ✓
- § 10 CHANGELOG draft → Task 22 ✓
- § 11 risks → covered in step-level assert messages (Task 3) and doc reminders (Tasks 18, 19) ✓
- § 12 file-order suggestion → followed in Phase 1→2→3→4 ordering ✓
- Appendix A unknowns → Phase 2 tasks include "Read existing structure first" steps for each ✓

**Placeholder scan:** Spot-checked grep targets:
- No "TODO" / "TBD" / "FIXME" in code-step bodies
- All commands have expected output
- All commit messages are full sentences, not placeholders

**Type consistency:**
- `SizeAdapter` defined in Task 1, referenced consistently
- `IdentitySizeAdapter` / `Mock2xAdapter` names consistent across tasks
- `sw/sh/sr/ssp` helper names consistent
- `Tailwind.instance.screenW` / `screenH` (lowercase, public) — consistent across Tasks 2, 3, 17

**Known imperfection:**

Tasks 9, 11, 12, 14 include "find the construction site by grep, then apply the pattern" rather than giving exact line numbers. This is intentional — those file structures weren't read during plan writing, and a "Step 1: read the file" + "Step 4: apply pattern X" formulation is more honest than pretending I know lines I haven't seen. A skilled developer following the plan can navigate this.

---

## Execution

Plan complete and saved to `doc/superpowers/plans/2026-05-16-size-adapter-v2.md`. Two execution options:

**1. Subagent-Driven (recommended)** — I dispatch a fresh subagent per task, review between tasks, fast iteration. Good when tasks are independent and I want to keep this conversation focused on review/decisions.

**2. Inline Execution** — Execute tasks in this session using executing-plans, batch execution with checkpoints. Good when I want to be hands-on at every step.

Which approach?
