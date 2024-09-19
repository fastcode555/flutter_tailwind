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
  /// same like the fontSize
  T font(double fontSize) => this..fontSize = fontSize;

  /// same like the fontSize,crazy short
  T f(double fontSize) => this..fontSize = fontSize;

  /// set the fontSize is 5.sp
  T get f5 => this..fontSize = 5.sp;

  /// set the fontSize is 6.sp
  T get f6 => this..fontSize = 6.sp;

  /// set the fontSize is 7.sp
  T get f7 => this..fontSize = 7.sp;

  /// set the fontSize is 8.sp
  T get f8 => this..fontSize = 8.sp;

  /// set the fontSize is 9.sp
  T get f9 => this..fontSize = 9.sp;

  /// set the fontSize is 10.sp
  T get f10 => this..fontSize = 10.sp;

  /// set the fontSize is 11.sp
  T get f11 => this..fontSize = 11.sp;

  /// set the fontSize is 12.sp
  T get f12 => this..fontSize = 12.sp;

  /// set the fontSize is 13.sp
  T get f13 => this..fontSize = 13.sp;

  /// set the fontSize is 14.sp
  T get f14 => this..fontSize = 14.sp;

  /// set the fontSize is 15.sp
  T get f15 => this..fontSize = 15.sp;

  /// set the fontSize is 16.sp
  T get f16 => this..fontSize = 16.sp;

  /// set the fontSize is 17.sp
  T get f17 => this..fontSize = 17.sp;

  /// set the fontSize is 18.sp
  T get f18 => this..fontSize = 18.sp;

  /// set the fontSize is 19.sp
  T get f19 => this..fontSize = 19.sp;

  /// set the fontSize is 20.sp
  T get f20 => this..fontSize = 20.sp;

  /// set the fontSize is 21.sp
  T get f21 => this..fontSize = 21.sp;

  /// set the fontSize is 22.sp
  T get f22 => this..fontSize = 22.sp;

  /// set the fontSize is 23.sp
  T get f23 => this..fontSize = 23.sp;

  /// set the fontSize is 24.sp
  T get f24 => this..fontSize = 24.sp;

  /// set the fontSize is 25.sp
  T get f25 => this..fontSize = 25.sp;

  /// set the fontSize is 26.sp
  T get f26 => this..fontSize = 26.sp;

  /// set the fontSize is 27.sp
  T get f27 => this..fontSize = 27.sp;

  /// set the fontSize is 28.sp
  T get f28 => this..fontSize = 28.sp;

  /// set the fontSize is 29.sp
  T get f29 => this..fontSize = 29.sp;

  /// set the fontSize is 30.sp
  T get f30 => this..fontSize = 30.sp;

  /// set the fontSize is 31.sp
  T get f31 => this..fontSize = 31.sp;

  /// set the fontSize is 32.sp
  T get f32 => this..fontSize = 32.sp;

  /// set the fontSize is 33.sp
  T get f33 => this..fontSize = 33.sp;

  /// set the fontSize is 34.sp
  T get f34 => this..fontSize = 34.sp;

  /// set the fontSize is 35.sp
  T get f35 => this..fontSize = 35.sp;

  /// set the fontSize is 36.sp
  T get f36 => this..fontSize = 36.sp;

  /// set the fontSize is 37.sp
  T get f37 => this..fontSize = 37.sp;

  /// set the fontSize is 38.sp
  T get f38 => this..fontSize = 38.sp;

  /// set the fontSize is 38.sp
  T get f39 => this..fontSize = 38.sp;

  /// set the fontSize is 40.sp
  T get f40 => this..fontSize = 40.sp;

  /// set the fontSize is 42.sp
  T get f42 => this..fontSize = 42.sp;

  /// set the fontSize is 44.sp
  T get f44 => this..fontSize = 44.sp;

  /// set the fontSize is 46.sp
  T get f46 => this..fontSize = 46.sp;

  /// set the fontSize is 48.sp
  T get f48 => this..fontSize = 48.sp;

  /// set the fontSize is 50.sp
  T get f50 => this..fontSize = 50.sp;

  /// set the fontSize is 52.sp
  T get f52 => this..fontSize = 52.sp;

  /// set the fontSize is 54.sp
  T get f54 => this..fontSize = 54.sp;

  /// set the fontSize is 56.sp
  T get f56 => this..fontSize = 56.sp;

  /// set the fontSize is 58.sp
  T get f58 => this..fontSize = 58.sp;

  /// set the fontSize is 60.sp
  T get f60 => this..fontSize = 60.sp;

  /// set the fontSize is 65.sp
  T get f65 => this..fontSize = 65.sp;

  /// set the fontSize is 70.sp
  T get f70 => this..fontSize = 70.sp;

  /// set the fontSize is 75.sp
  T get f75 => this..fontSize = 75.sp;

  /// set the fontSize is 80.sp
  T get f80 => this..fontSize = 80.sp;

  /// set the fontSize is 85.sp
  T get f85 => this..fontSize = 85.sp;

  /// set the fontSize is 90.sp
  T get f90 => this..fontSize = 90.sp;

  /// set the fontSize is 95.sp
  T get f95 => this..fontSize = 95.sp;

  /// set the fontSize is 100.sp
  T get f100 => this..fontSize = 100.sp;
}
