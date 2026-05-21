## 2.0.1

### Fixes

- Fix `AutoSizeText` assertion crash when using `.text.fN.fM.mk` (auto-shrink-to-fit text) together with a non-Identity `SizeAdapter`. v2.0.0's `ssp()` threading produced fractional values that violated `AutoSizeText`'s `stepGranularity=1` requirement. Both `minFontSize` and the style's `fontSize` are now rounded to integers after `ssp()`. Regression test added covering a `_MockFractionalSpAdapter` (mimics screenutil-on-desktop `.sp` factors).

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

## 1.8.0

- `Tailwind.instance.primary` no longer throws `Looking up a deactivated widget's ancestor is unsafe` when accessed after the holding widget has been disposed; it now falls back to `primaryColor ?? Colors.amber`. Added 5 widget tests covering init/no-init/disposal scenarios — the first real unit tests in this repo.
- Replaced deprecated `Color.withOpacity` with `Color.withValues(alpha:)` internally (no behavior change for users — same alpha-modified color, better precision in the new color pipeline).
- New `doc/` directory as the documentation single-source-of-truth:
  - `doc/getting-started.md` — install, bare-minimum usage, theme primary color setup with the **correct** init position
  - `doc/patterns/screen-adaptation.md` — `.adaptW` / `.adaptH` / `.adaptR` / `.adaptSp` (the opt-in screen-scaling API introduced in 1.7.x but undocumented until now)
  - `doc/patterns/spacing.md` — `spacing2..spacing32` shortcuts vs manual spacers
- `.cursor/rules/flutter_tailwind.mdc` fixed several stale teachings:
  - Removed the recommendation to run `flutter packages pub run build_runner build` (this library does not use `build_runner`)
  - Rewrote the `Tailwind.instance.init(context)` example — init must be called from inside `MaterialApp`, not from `ScreenUtilInit.builder` (the context there is above MaterialApp, so `Theme.of` returns `ThemeData.fallback()` instead of your theme — `.primary` ends up the wrong color)
- README adds a documentation-navigation section at the top and an explicit note that this library does not use `build_runner`.
- `guide.md` adds a migration banner pointing at `doc/`.

## 1.4.8

- Add the wrap widget

## 1.4.7

- 1.Support maxW, maxH
- 2.Support setting the color of a border individually for the container

## 1.4.4

- add the positioned widget

## 1.4.2

- Just update the document

## 1.4.1

- Provide more expanded*

## 1.3.9

- Provide the function for container to have key

## 1.3.8

- also let the container have expanded feature

## 1.3.7

- add the p,to generate the EdgeInsetsGeometry

## 1.3.6

- fix the bug which cannot load the rounded image

## 1.3.5

- let the image loader support loading base64 picture

## 1.3.4

- add the AutoSizeText as basic component,people can use 'text.f30.f10.black.mk'，f30:max font
  size,f10 min font size

## 1.3.2

- let text support expanded

## 1.3.1

- fixed the padding problem

## 1.3.0

- add more prefer define padding ,margin and others

## 1.2.8

- add the padding widget and let some width directly support padding,so no need wrap into padding

## 1.2.7

- add more padding value and margin value

## 1.2.6

- fixed the web cannot load image problem.
- fixed the warning of flutter lints

## 1.2.5

- add other default size,people use it should open obfuscate,let system reduce the useless code

## 1.1.3

- fixed the input widget bugs

## 1.1.0

- add the widget like input,checkbox,radio

## 1.0.1

- add some description and demo

## 1.0.0

- Initial version,