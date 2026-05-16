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