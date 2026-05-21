import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// SizeAdapter that routes flutter_tailwind's geometry/font scaling
/// through `flutter_screenutil`'s `.w` / `.h` / `.r` / `.sp` extensions.
///
/// Install once at app startup:
/// ```dart
/// void main() {
///   Tailwind.instance.configSizeAdapter(const ScreenUtilSizeAdapter());
///   runApp(const MyApp());
/// }
/// ```
///
/// After installation, every geometry value the library sees
/// (`.p16`, `.w200`, `.f24`, etc.) is scaled to the active device.
/// You do NOT need to write `.r` / `.w` / `.h` / `.sp` inside library
/// chain calls anymore — the adapter handles it.
///
/// You still need `.r` / `.w` / `.h` / `.sp` in **native Flutter
/// constructors** (`EdgeInsets.all(16.r)`, `TextStyle(fontSize: 30.sp)`)
/// because the adapter only sees calls into flutter_tailwind builders.
class ScreenUtilSizeAdapter implements SizeAdapter {
  const ScreenUtilSizeAdapter();

  @override
  double w(double v) => v.w;

  @override
  double h(double v) => v.h;

  @override
  double r(double v) => v.r;

  @override
  double sp(double v) => v.sp;
}
