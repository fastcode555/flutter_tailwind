import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin FontSizeBuilder {
  double? fontSize;
}

extension FontSizeBuilderExt<T extends FontSizeBuilder> on T {
  T fontSize(double fontSize) => this..fontSize = fontSize;

  /// same like the fontSize
  T font(double fontSize) => this..fontSize = fontSize;

  /// same like the fontSize,crazy short
  T f(double fontSize) => this..fontSize = fontSize;

  T get f5 => this..fontSize = 5.sp;

  T get f6 => this..fontSize = 6.sp;

  T get f7 => this..fontSize = 7.sp;

  T get f8 => this..fontSize = 8.sp;

  T get f9 => this..fontSize = 9.sp;

  T get f10 => this..fontSize = 10.sp;

  T get f11 => this..fontSize = 11.sp;

  T get f12 => this..fontSize = 12.sp;

  T get f13 => this..fontSize = 13.sp;

  T get f14 => this..fontSize = 14.sp;

  T get f15 => this..fontSize = 15.sp;

  T get f16 => this..fontSize = 16.sp;

  T get f17 => this..fontSize = 17.sp;

  T get f18 => this..fontSize = 18.sp;

  T get f19 => this..fontSize = 19.sp;

  T get f20 => this..fontSize = 20.sp;

  T get f22 => this..fontSize = 22.sp;

  T get f24 => this..fontSize = 24.sp;

  T get f26 => this..fontSize = 26.sp;

  T get f28 => this..fontSize = 28.sp;

  T get f30 => this..fontSize = 30.sp;

  T get f32 => this..fontSize = 32.sp;

  T get f34 => this..fontSize = 34.sp;

  T get f36 => this..fontSize = 36.sp;

  T get f38 => this..fontSize = 38.sp;

  T get f40 => this..fontSize = 40.sp;

  T get f42 => this..fontSize = 42.sp;

  T get f44 => this..fontSize = 44.sp;

  T get f46 => this..fontSize = 46.sp;

  T get f48 => this..fontSize = 48.sp;

  T get f50 => this..fontSize = 50.sp;

  T get f52 => this..fontSize = 52.sp;

  T get f54 => this..fontSize = 54.sp;

  T get f56 => this..fontSize = 56.sp;

  T get f58 => this..fontSize = 58.sp;

  T get f60 => this..fontSize = 60.sp;
}
