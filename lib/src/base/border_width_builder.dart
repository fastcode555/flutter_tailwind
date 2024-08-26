import 'package:flutter_screenutil/flutter_screenutil.dart';
/// Barry
/// @date 7/11/23
/// describe:
mixin BorderWidthBuilder {
  double? borderWidth;
}

extension BorderWidthBuilderExt<T extends BorderWidthBuilder> on T {
  T borderWidth(double borderWidth) => this..borderWidth = borderWidth;

  T get border0 => this..borderWidth = 0;

  T get border1 => this..borderWidth = 1.r;

  T get border2 => this..borderWidth = 2.r;

  T get border3 => this..borderWidth = 3.r;

  T get border4 => this..borderWidth = 4.r;

  T get border5 => this..borderWidth = 5.r;

  T get border6 => this..borderWidth = 6.r;

  T get border7 => this..borderWidth = 7.r;

  T get border8 => this..borderWidth = 8.r;

  T get border9 => this..borderWidth = 9.r;

  T get border10 => this..borderWidth = 10.r;

  T get border12 => this..borderWidth = 12.r;

  T get border14 => this..borderWidth = 14.r;

  T get border16 => this..borderWidth = 16.r;

  T get border18 => this..borderWidth = 18.r;

  T get border20 => this..borderWidth = 20.r;

  T get border22 => this..borderWidth = 22.r;

  T get border24 => this..borderWidth = 24.r;

  T get border26 => this..borderWidth = 26.r;

  T get border28 => this..borderWidth = 28.r;

  T get border30 => this..borderWidth = 30.r;

  T get border32 => this..borderWidth = 32.r;

  T get border34 => this..borderWidth = 34.r;

  T get border36 => this..borderWidth = 36.r;

  T get border38 => this..borderWidth = 38.r;

  T get border40 => this..borderWidth = 40.r;

  T get border42 => this..borderWidth = 42.r;

  T get border44 => this..borderWidth = 44.r;

  T get border46 => this..borderWidth = 46.r;

  T get border48 => this..borderWidth = 48.r;

  T get border50 => this..borderWidth = 50.r;
}
