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
