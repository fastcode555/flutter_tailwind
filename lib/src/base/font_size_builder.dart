import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin FontSizeBuilder {
  double? fontSize;
}

extension CustomSp on num {
  double get csp => ScreenUtil().screenWidth < 400 ? sp : toDouble();
}

extension FontSizeBuilderExt<T extends FontSizeBuilder> on T {
  T fontSize(double fontSize) => this..fontSize = fontSize;

  /// same like the fontSize
  T font(double fontSize) => this..fontSize = fontSize;

  /// same like the fontSize,crazy short
  T f(double fontSize) => this..fontSize = fontSize;

  T get f5 => this..fontSize = 5.csp;

  T get f6 => this..fontSize = 6.csp;

  T get f7 => this..fontSize = 7.csp;

  T get f8 => this..fontSize = 8.csp;

  T get f9 => this..fontSize = 9.csp;

  T get f10 => this..fontSize = 10.csp;

  T get f11 => this..fontSize = 11.csp;

  T get f12 => this..fontSize = 12.csp;

  T get f13 => this..fontSize = 13.csp;

  T get f14 => this..fontSize = 14.csp;

  T get f15 => this..fontSize = 15.csp;

  T get f16 => this..fontSize = 16.csp;

  T get f17 => this..fontSize = 17.csp;

  T get f18 => this..fontSize = 18.csp;

  T get f19 => this..fontSize = 19.csp;

  T get f20 => this..fontSize = 20.csp;

  T get f21 => this..fontSize = 21.csp;

  T get f22 => this..fontSize = 22.csp;

  T get f23 => this..fontSize = 23.csp;

  T get f24 => this..fontSize = 24.csp;

  T get f25 => this..fontSize = 25.csp;

  T get f26 => this..fontSize = 26.csp;

  T get f27 => this..fontSize = 27.csp;

  T get f28 => this..fontSize = 28.csp;

  T get f29 => this..fontSize = 29.csp;

  T get f30 => this..fontSize = 30.csp;

  T get f31 => this..fontSize = 31.csp;

  T get f32 => this..fontSize = 32.csp;

  T get f33 => this..fontSize = 33.csp;

  T get f34 => this..fontSize = 34.csp;

  T get f35 => this..fontSize = 35.csp;

  T get f36 => this..fontSize = 36.csp;

  T get f37 => this..fontSize = 37.csp;

  T get f38 => this..fontSize = 38.csp;

  T get f39 => this..fontSize = 38.csp;

  T get f40 => this..fontSize = 40.csp;

  T get f42 => this..fontSize = 42.csp;

  T get f44 => this..fontSize = 44.csp;

  T get f46 => this..fontSize = 46.csp;

  T get f48 => this..fontSize = 48.csp;

  T get f50 => this..fontSize = 50.csp;

  T get f52 => this..fontSize = 52.csp;

  T get f54 => this..fontSize = 54.csp;

  T get f56 => this..fontSize = 56.csp;

  T get f58 => this..fontSize = 58.csp;

  T get f60 => this..fontSize = 60.csp;

  T get f65 => this..fontSize = 65.csp;

  T get f70 => this..fontSize = 70.csp;

  T get f75 => this..fontSize = 75.csp;

  T get f80 => this..fontSize = 80.csp;

  T get f85 => this..fontSize = 85.csp;

  T get f90 => this..fontSize = 90.csp;

  T get f95 => this..fontSize = 95.csp;

  T get f100 => this..fontSize = 100.csp;
}
