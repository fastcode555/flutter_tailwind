# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project type

This is a **Flutter package** (UI library), not an application. The library lives in `lib/`; runnable demos live in `example/`. There is no top-level Flutter app to `flutter run`.

The package goal: provide a TailwindCSS-style chained-API for Flutter widgets, e.g.
`'Hello'.text.red.f16.bold.mk` or `container.s100.red.rounded8.border2.child(widget)`.

## Common commands

```bash
# Package-level (run from repo root)
flutter pub get
flutter analyze                    # lint (config: analysis_options.yaml)
flutter test                       # runs files in test/ — see note below

# Run the demo app
cd example && flutter pub get && flutter run

# Publish flow (see PAY_ATTENTION.md)
flutter pub publish --dry-run
fvm flutter packages pub publish --server=https://pub.dartlang.org
```

**Note on `test/`:** The package has no real test suite. Don't rely on `flutter test` for verification; rely on `flutter analyze` and on building/running `example/`. A future v1.12 milestone is planned to add a baseline of widget tests (see `docs/superpowers/specs/2026-05-15-flutter-tailwind-analysis.md`).

**Note on `.g.dart` files:** Files like `text.g.dart`, `check_box.g.dart`, `list_view.g.dart` are *not* `build_runner` outputs. They are **hand-written `part` files** of their sibling (`text.dart`, etc.) containing the mixins for the chained API. Edit them directly. The preset values they hold are considered stable — large batches of new presets are not expected. There is no `build_runner` step for this package, and no code-generation pipeline. The `.cursor/rules` file's instructions to run `build_runner build` are stale and should be ignored.

## Architecture

### The chained-API pattern

Every widget builder is a class extending `MkBuilder<T>` (or a variant) defined in `lib/src/base/mk_builder.dart`. Chained calls mutate fields on the builder, and a terminal call materializes the widget:

- `.mk` — terminates a builder with no required child (the most common terminator).
- `.child(widget)` / `.children([...])` — terminates `ChildMkBuilder` / a `ChildrenBuilder`.
- `.click(onTap: ...)` / `.iconClick(...)` — wraps the result in `GestureDetector` / `IconButton` (debounced via `Debouncer`).
- `.onChanged(...)` — terminates form builders (`checkBox`, `radio`).
- `.builder(count, itemBuilder)` / `.dataBuilder<T>(list, builder)` — terminates list/grid builders.

When adding chain steps, return `this` (typed as `T`) so the call chain stays composable.

### Mixin composition

Each style axis is a separate mixin in `lib/src/base/*.dart`: `ColorBuilder`, `BorderColorBuilder`, `SizeBuilder`, `FontSizeBuilder`, `PaddingBuilder`, `MarginBuilder`, `BorderRadiusBuilder`, `ShadowBuilder`, `AlignmentBuilder`, `ExpandedBuilder`, `KeyBuilder`, `IconBuilder`, `ImageFeature`, `TextFeature`, `PositionedBuilder`, etc.

A concrete builder (`TextBuilder`, `ContainerBuilder`, `RowBuilder`, etc.) composes whichever axes it supports via `with` clauses. The chain methods themselves are exposed as **extensions on those mixins** — e.g. `extension XxxExt<T extends ColorBuilder> on T { T get red => this..innerColor = Colors.red; }`. This means adding a new color or size automatically makes it available on every builder that mixes in the relevant base.

Row/Column/Wrap mix in the full container axis set (size, padding, margin, color, radius, border, shadow, spacing). When working in this codebase, **do not wrap Row/Column in Container just to set background/padding/size** — set them directly on the Row/Column.

### Terminator naming: `.mk` means "make"

`mk` is the universal "build the widget now" getter. It exists because Dart property access reads better than `.build()` mid-chain. Always end a builder chain that has no required child with `.mk`.

### Singleton config

`Tailwind` (lib/src/tailwind.dart) is a singleton holding optional `BuildContext`, primary color, and a pluggable `BaseImageFactory` / `ImageLoaderConfigInterface`. Callers init it once (typically inside `ScreenUtilInit.builder`) — e.g. `Tailwind.instance.init(context, Colors.blue)` and `Tailwind.instance.addImageConfig(MyConfig())`. The `.primary` color getter falls back through context → user-provided → `Colors.amber`.

### Responsive sizing

The package re-exports `flutter_screenutil` and uses its `.r` / `.w` / `.h` / `.sp` extensions internally for most size-related mixins. Consumers must wrap their app in `ScreenUtilInit(designSize: Size(375, 812), ...)`. Recent commits intentionally removed default screen adaptation from many properties — consumers now opt in explicitly with `adaptH` / `adaptS` / `adaptR` / `adaptSp` (see commit `2ed8c91`).

### Image loading

`lib/src/image_loader/` defines a pluggable image loading layer used by `'url'.image.s100.mk` and `R.asset.asset.s100.mk`. Network images go through `cached_network_image`; consumers can swap in custom loaders via `Tailwind.instance.configImageFactory(...)`.

### Public surface

Everything intended for consumers is re-exported from `lib/flutter_tailwind.dart`. When adding a new builder file, add its export there. The package also re-exports `cached_network_image`, `flutter_screenutil`, and `flutter_staggered_grid_view` so consumers do not need to depend on them separately.

## Project conventions

These come from `.cursor/rules/flutter_tailwind.mdc` and `analysis_options.yaml`. The cursor rules file is ~52KB of detailed guidance — consult it directly for component-by-component API. Highlights:

- **Lints:** `prefer_single_quotes`, `avoid_print`, `prefer_const_constructors`, `avoid_redundant_argument_values`, `omit_local_variable_types`, `unnecessary_new`. Run `flutter analyze` before committing.
- **Predefined > parameterized.** When a value has a predefined shortcut (e.g. `.l16`, `.spacing20`, `.p8`, `.s50`), use it — do not write `.l(16)`, `.spacing(20)`. Predefined integer ranges typically cover 0–100 step 2. Only fall back to the parameterized form for values without a shortcut (e.g. `.l(17.5)`, `.spacing(25)`).
- **Don't wrap Row/Column in Container** to set size/padding/color/radius/border/shadow — Row/Column mix in those axes directly. Same for SizedBox-wrapping just to set width/height.
- **Avoid manual spacers (`h16`, `w8`) between children when all gaps are equal.** Use `.spacing16` on the parent Row/Column instead. *But* keep manual spacers when gaps are intentionally non-uniform (visual hierarchy beats uniformity).
- **Strip redundant single-child wrappers.** A Column with one child, a Stack with one child, nested Containers that could merge — collapse them.

## Adding preset values

Preset values (sizes, paddings, colors, etc.) are considered stable. If you do need to add new ones (rare), edit the relevant `.g.dart` file directly by hand. There is no codegen pipeline and none is planned.

## CI

`.github/workflows/build.yml` only builds the `example/` app (Android APK + iOS IPA, unsigned) on push to `main`/`master` and creates a dated GitHub Release. It does not run `flutter test` or `flutter analyze` against the library itself.
