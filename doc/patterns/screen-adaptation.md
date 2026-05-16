# Screen Adaptation: `.adaptW` / `.adaptH` / `.adaptR` / `.adaptSp`

> **Status:** introduced in commit `2ed8c91` (1.7.x). Previously the library applied screen-adaptation silently inside builders; this often produced surprising scaling. Adaptation is now **opt-in per call**.

## The 4 adapters

Each is a getter on the builder. Each takes whatever raw value you already set on the chain and runs it through one of `flutter_screenutil`'s scaling functions.

| Getter | What it scales | Underlying call | Use for |
|---|---|---|---|
| `.adaptW` | the `width` field | `width.w` (proportional to screen width) | widths |
| `.adaptH` | the `height` field | `height.h` (proportional to screen height) | heights |
| `.adaptR` | the `size` field (square) | `size.r` (responsive radius/diameter) | square boxes, icons |
| `.adaptSp` | the `fontSize` (or `fontSizes` list) | `fontSize.sp` (scaled font) | text sizes |

## Example

```dart
// Without any adapter — literal pixels, no scaling
container.w200.h100.red.mk
// width=200px, height=100px on every device

// With adapters — values scale per the device
container.w200.adaptW.h100.adaptH.red.mk
// width≈200 on a 375pt-wide design, scaled up/down on other devices

// Text
'hello'.text.f24.adaptSp.bold.mk
// font scales with the screen
```

## Order matters

The adapter consumes whatever value is currently on the builder. **Call the adapter after the value-setting getter:**

```dart
// ✅ Correct
container.w200.adaptW.mk

// ❌ Wrong — adaptW runs against null width, then .w200 sets a literal value
container.adaptW.w200.mk
```

## Without `ScreenUtilInit`

If you never wrap your app in `ScreenUtilInit`, the underlying screenutil `.w` / `.h` / `.r` / `.sp` extensions return the original number unchanged. So calling `.adaptW` etc. is a **no-op** — safe but pointless.

In other words: the adapters never make things worse, they just don't help if there's no `ScreenUtilInit` providing the device scaling info.

## Mixing literal and adapted sizes in one chain

This is the common case — some values should scale, some shouldn't:

```dart
container
  .w200.adaptW       // width scales with device
  .h(1).             // hairline divider — must stay 1px, do NOT adapt
  .grey
  .mk
```

## Comparison to previous behavior

Before commit `2ed8c91`:

```dart
// 1.6.x and earlier — implicit scaling
container.w200.mk
// internally: width = 200.w  (always scaled)
```

After 1.7.x:

```dart
container.w200.mk          // width = 200 literal pixels
container.w200.adaptW.mk   // width = 200.w (scaled)
```

This is a **breaking semantic change**, but the new behavior is more predictable: what you write is what you get unless you explicitly ask for adaptation.

## When to use each

- **`.adaptR`** — for square icons / avatars / placeholders where the size is conceptually one number. `R.icDefPlaylist.asset.s100.adaptR.mk`
- **`.adaptW`** / **`.adaptH`** — for layouts that should fill a percentage of screen width/height. `container.w200.adaptW.mk` is a card that feels the right size on phones and tablets
- **`.adaptSp`** — almost always for fonts. `.text.f16.adaptSp.mk` keeps body text legible across device sizes. Without it, `.f16` is literally 16 logical pixels everywhere
- **No adapter** — for fixed-pixel UI: hairlines, dividers, exact-match designs from a fixed spec
