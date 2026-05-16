# Getting Started

## Install

```yaml
# pubspec.yaml
dependencies:
  flutter_tailwind: ^1.7.3
```

```bash
flutter pub get
```

## Bare-minimum usage

You can use `flutter_tailwind` immediately without any initialization. Most builders work the moment you import them:

```dart
import 'package:flutter_tailwind/flutter_tailwind.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 'Hello, world'.text.f24.bold.red.mk,
      ),
    );
  }
}
```

That's it. Sizes are passed through as literal logical pixels (no screen scaling).

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

## Setting up a primary color (optional)

If your code uses `.primary` / `.textPrimary` / `.borderPrimary` and you want them tied to your app theme, call `Tailwind.instance.init(context)` **from inside the `MaterialApp` widget tree**:

```dart
return MaterialApp(
  theme: ThemeData(primaryColor: Colors.blue),
  builder: (context, child) {
    Tailwind.instance.init(context);  // ✅ context is inside MaterialApp
    return child!;
  },
  home: const HomePage(),
);
```

Alternatively, set a static fallback (no `BuildContext` needed):

```dart
void main() {
  Tailwind.instance.primaryColor = Colors.blue;
  runApp(const MyApp());
}
```

> **Important — do not init above `MaterialApp`.**
>
> ```dart
> // ❌ Wrong
> return ScreenUtilInit(
>   builder: (context, child) {
>     Tailwind.instance.init(context, Colors.blue);  // context is ABOVE MaterialApp
>     return MaterialApp(theme: ThemeData(primaryColor: Colors.red), ...);
>   },
> );
> ```
>
> The `context` from `ScreenUtilInit.builder` sits above `MaterialApp`, so `Theme.of(context)` returns `ThemeData.fallback()` — `.primary` ends up `Color(0xff673AB7)` (a default deep purple), not your `Colors.red`. Always init the context from inside the `MaterialApp`.
>
> If you skip `init` entirely, `.primary` falls back to `primaryColor ?? Colors.amber` — which is the default for all the existing example code.

## What to read next

- [`patterns/spacing.md`](patterns/spacing.md) — controlling gap between children
- [`patterns/screen-adaptation.md`](patterns/screen-adaptation.md) — `.adaptW` / `.adaptH` / `.adaptR` / `.adaptSp`
- `README.md` of the repo for the visual feature gallery
