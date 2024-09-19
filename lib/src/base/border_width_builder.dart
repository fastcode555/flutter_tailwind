import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin BorderWidthBuilder {
  double? innerBorderWidth;
}

extension BorderWidthBuilderExt<T extends BorderWidthBuilder> on T {
  T borderWidth(double borderWidth) => this..innerBorderWidth = borderWidth;

  T get border0 => this..innerBorderWidth = 0;

  T get border1 => this..innerBorderWidth = 1.r;

  T get border2 => this..innerBorderWidth = 2.r;

  T get border3 => this..innerBorderWidth = 3.r;

  T get border4 => this..innerBorderWidth = 4.r;

  T get border5 => this..innerBorderWidth = 5.r;

  T get border6 => this..innerBorderWidth = 6.r;

  T get border7 => this..innerBorderWidth = 7.r;

  T get border8 => this..innerBorderWidth = 8.r;

  T get border9 => this..innerBorderWidth = 9.r;

  T get border10 => this..innerBorderWidth = 10.r;

  T get border12 => this..innerBorderWidth = 12.r;

  T get border14 => this..innerBorderWidth = 14.r;

  T get border16 => this..innerBorderWidth = 16.r;

  T get border18 => this..innerBorderWidth = 18.r;

  T get border20 => this..innerBorderWidth = 20.r;

  T get border22 => this..innerBorderWidth = 22.r;

  T get border24 => this..innerBorderWidth = 24.r;

  T get border26 => this..innerBorderWidth = 26.r;

  T get border28 => this..innerBorderWidth = 28.r;

  T get border30 => this..innerBorderWidth = 30.r;

  T get border32 => this..innerBorderWidth = 32.r;

  T get border34 => this..innerBorderWidth = 34.r;

  T get border36 => this..innerBorderWidth = 36.r;

  T get border38 => this..innerBorderWidth = 38.r;

  T get border40 => this..innerBorderWidth = 40.r;

  T get border42 => this..innerBorderWidth = 42.r;

  T get border44 => this..innerBorderWidth = 44.r;

  T get border46 => this..innerBorderWidth = 46.r;

  T get border48 => this..innerBorderWidth = 48.r;

  T get border50 => this..innerBorderWidth = 50.r;
}
