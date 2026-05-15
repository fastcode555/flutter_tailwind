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

## Adding screen adaptation (optional)

If you want sizes/fonts to scale with the device, wrap your app in `ScreenUtilInit` (from `flutter_screenutil`, which `flutter_tailwind` re-exports):

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: HomePage());
      },
    );
  }
}
```

Once `ScreenUtilInit` is in place, you opt sizes/fonts into adaptation by appending `.adaptW` / `.adaptH` / `.adaptR` / `.adaptSp` — see [`patterns/screen-adaptation.md`](patterns/screen-adaptation.md).

> **Why opt-in?** Earlier versions adapted sizes silently. This caused surprises (a `s100` rendered at 134 pixels on a wider device). Since commit `2ed8c91` adaptation is explicit — the library does not silently scale anymore.

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
