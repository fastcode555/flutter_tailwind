import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin FontSizeBuilder {
  double? fontSize;
  List<double>? fontSizes;
}

extension CustomSp on num {
  double get csp => ScreenUtil().screenWidth < 400 ? sp : toDouble();
}

extension FontSizeBuilderExt<T extends FontSizeBuilder> on T {
  /// same like the fontSize
  T font(double? fontSize) {
    //only use two time, will create a list to collect the color
    if (this.fontSize != null) {
      fontSizes ??= [];
      fontSizes?.add(this.fontSize!);
    }
    if (fontSize != null) {
      fontSizes?.add(fontSize);
    }
    return this..fontSize = fontSize;
  }

  /// same like the fontSize,crazy short
  T f(double? fontSize) {
    //only use two time, will create a list to collect the color
    if (this.fontSize != null) {
      fontSizes ??= [];
      fontSizes?.add(this.fontSize!);
    }
    if (fontSize != null) {
      fontSizes?.add(fontSize);
    }
    return this..fontSize = fontSize;
  }

  T get adaptSp {
    if (fontSizes != null) {
      for (int i = 0; i < (fontSizes?.length ?? 0); i++) {
        fontSizes![i] = fontSizes![i].sp;
      }
    } else {
      this.fontSize = this.fontSize?.sp;
    }
    return this;
  }

  /// set the fontSize is 5.sp
  T get f5 => this..f(5);

  /// set the fontSize is 6.sp
  T get f6 => this..f(6);

  /// set the fontSize is 7.sp
  T get f7 => this..f(7);

  /// set the fontSize is 8.sp
  T get f8 => this..f(8);

  /// set the fontSize is 9.sp
  T get f9 => this..f(9);

  /// set the fontSize is 10.sp
  T get f10 => this..f(10);

  /// set the fontSize is 11.sp
  T get f11 => this..f(11);

  /// set the fontSize is 12.sp
  T get f12 => this..f(12);

  /// set the fontSize is 13.sp
  T get f13 => this..f(13);

  /// set the fontSize is 14.sp
  T get f14 => this..f(14);

  /// set the fontSize is 15.sp
  T get f15 => this..f(15);

  /// set the fontSize is 16.sp
  T get f16 => this..f(16);

  /// set the fontSize is 17.sp
  T get f17 => this..f(17);

  /// set the fontSize is 18.sp
  T get f18 => this..f(18);

  /// set the fontSize is 19.sp
  T get f19 => this..f(19);

  /// set the fontSize is 20.sp
  T get f20 => this..f(20);

  /// set the fontSize is 21.sp
  T get f21 => this..f(21);

  /// set the fontSize is 22.sp
  T get f22 => this..f(22);

  /// set the fontSize is 23.sp
  T get f23 => this..f(23);

  /// set the fontSize is 24.sp
  T get f24 => this..f(24);

  /// set the fontSize is 25.sp
  T get f25 => this..f(25);

  /// set the fontSize is 26.sp
  T get f26 => this..f(26);

  /// set the fontSize is 27.sp
  T get f27 => this..f(27);

  /// set the fontSize is 28.sp
  T get f28 => this..f(28);

  /// set the fontSize is 29.sp
  T get f29 => this..f(29);

  /// set the fontSize is 30.sp
  T get f30 => this..f(30);

  /// set the fontSize is 31.sp
  T get f31 => this..f(31);

  /// set the fontSize is 32.sp
  T get f32 => this..f(32);

  /// set the fontSize is 33.sp
  T get f33 => this..f(33);

  /// set the fontSize is 34.sp
  T get f34 => this..f(34);

  /// set the fontSize is 35.sp
  T get f35 => this..f(35);

  /// set the fontSize is 36.sp
  T get f36 => this..f(36);

  /// set the fontSize is 37.sp
  T get f37 => this..f(37);

  /// set the fontSize is 38.sp
  T get f38 => this..f(38);

  /// set the fontSize is 38.sp
  T get f39 => this..f(38);

  /// set the fontSize is 40.sp
  T get f40 => this..f(40);

  /// set the fontSize is 42.sp
  T get f42 => this..f(42);

  /// set the fontSize is 44.sp
  T get f44 => this..f(44);

  /// set the fontSize is 46.sp
  T get f46 => this..f(46);

  /// set the fontSize is 48.sp
  T get f48 => this..f(48);

  /// set the fontSize is 50.sp
  T get f50 => this..f(50);

  /// set the fontSize is 52.sp
  T get f52 => this..f(52);

  /// set the fontSize is 54.sp
  T get f54 => this..f(54);

  /// set the fontSize is 56.sp
  T get f56 => this..f(56);

  /// set the fontSize is 58.sp
  T get f58 => this..f(58);

  /// set the fontSize is 60.sp
  T get f60 => this..f(60);

  /// set the fontSize is 65.sp
  T get f65 => this..f(65);

  /// set the fontSize is 70.sp
  T get f70 => this..f(70);

  /// set the fontSize is 75.sp
  T get f75 => this..f(75);

  /// set the fontSize is 80.sp
  T get f80 => this..f(80);

  /// set the fontSize is 85.sp
  T get f85 => this..f(85);

  /// set the fontSize is 90.sp
  T get f90 => this..f(90);

  /// set the fontSize is 95.sp
  T get f95 => this..f(95);

  /// set the fontSize is 100.sp
  T get f100 => this.f(100);
}
