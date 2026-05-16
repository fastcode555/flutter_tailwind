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
  @override double sp(double v) => v * scalingFactor;
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
