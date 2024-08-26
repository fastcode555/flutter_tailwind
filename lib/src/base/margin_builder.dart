import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin MarginBuilder {
  double? marginValue;
  double? marginLeft;
  double? marginRight;
  double? marginTop;
  double? marginBottom;

  double? marginHorizontal;
  double? marginVertical;

  EdgeInsetsGeometry? _innerMargin;

  bool get hasMargin =>
      _innerMargin != null ||
      marginValue != null ||
      marginHorizontal != null ||
      marginVertical != null ||
      marginLeft != null ||
      marginRight != null ||
      marginTop != null ||
      marginBottom != null;

  EdgeInsetsGeometry? get finalMargin {
    if (_innerMargin != null) return _innerMargin;
    if (hasMargin) {
      return EdgeInsets.only(
        left: marginLeft ?? marginHorizontal ?? marginValue ?? 0.0,
        right: marginRight ?? marginHorizontal ?? marginValue ?? 0.0,
        top: marginTop ?? marginVertical ?? marginValue ?? 0.0,
        bottom: marginBottom ?? marginVertical ?? marginValue ?? 0.0,
      );
    }
    return null;
  }
}

extension MarginBuilderBuilderExt<T extends MarginBuilder> on T {
  T margin(EdgeInsetsGeometry? padding) => this.._innerMargin = padding;

  T get m2 => this..marginValue = 2.r;

  T get m4 => this..marginValue = 4.r;

  T get m6 => this..marginValue = 6.r;

  T get m8 => this..marginValue = 8.r;

  T get m10 => this..marginValue = 10.r;

  T get m12 => this..marginValue = 12.r;

  T get m14 => this..marginValue = 14.r;

  T get m16 => this..marginValue = 16.r;

  T get m18 => this..marginValue = 18.r;

  T get m20 => this..marginValue = 20.r;

  T get m22 => this..marginValue = 22.r;

  T get m24 => this..marginValue = 24.r;

  T get m26 => this..marginValue = 26.r;

  T get m28 => this..marginValue = 28.r;

  T get m30 => this..marginValue = 30.r;

  T get m32 => this..marginValue = 32.r;

  T get ml2 => this..marginLeft = 2.r;

  T get ml4 => this..marginLeft = 4.r;

  T get ml6 => this..marginLeft = 6.r;

  T get ml8 => this..marginLeft = 8.r;

  T get ml10 => this..marginLeft = 10.r;

  T get ml12 => this..marginLeft = 12.r;

  T get ml14 => this..marginLeft = 14.r;

  T get ml16 => this..marginLeft = 16.r;

  T get ml18 => this..marginLeft = 18.r;

  T get ml20 => this..marginLeft = 20.r;

  T get ml22 => this..marginLeft = 22.r;

  T get ml24 => this..marginLeft = 24.r;

  T get ml26 => this..marginLeft = 26.r;

  T get ml28 => this..marginLeft = 28.r;

  T get ml30 => this..marginLeft = 30.r;

  T get ml32 => this..marginLeft = 32.r;

  T get mr2 => this..marginRight = 2.r;

  T get mr4 => this..marginRight = 4.r;

  T get mr6 => this..marginRight = 6.r;

  T get mr8 => this..marginRight = 8.r;

  T get mr10 => this..marginRight = 10.r;

  T get mr12 => this..marginRight = 12.r;

  T get mr14 => this..marginRight = 14.r;

  T get mr16 => this..marginRight = 16.r;

  T get mr18 => this..marginRight = 18.r;

  T get mr20 => this..marginRight = 20.r;

  T get mr22 => this..marginRight = 22.r;

  T get mr24 => this..marginRight = 24.r;

  T get mr26 => this..marginRight = 26.r;

  T get mr28 => this..marginRight = 28.r;

  T get mr30 => this..marginRight = 30.r;

  T get mr32 => this..marginRight = 32.r;

  T get mt2 => this..marginTop = 2.r;

  T get mt4 => this..marginTop = 4.r;

  T get mt6 => this..marginTop = 6.r;

  T get mt8 => this..marginTop = 8.r;

  T get mt10 => this..marginTop = 10.r;

  T get mt12 => this..marginTop = 12.r;

  T get mt14 => this..marginTop = 14.r;

  T get mt16 => this..marginTop = 16.r;

  T get mt18 => this..marginTop = 18.r;

  T get mt20 => this..marginTop = 20.r;

  T get mt22 => this..marginTop = 22.r;

  T get mt24 => this..marginTop = 24.r;

  T get mt26 => this..marginTop = 26.r;

  T get mt28 => this..marginTop = 28.r;

  T get mt30 => this..marginTop = 30.r;

  T get mt32 => this..marginTop = 32.r;

  T get mb2 => this..marginBottom = 2.r;

  T get mb4 => this..marginBottom = 4.r;

  T get mb6 => this..marginBottom = 6.r;

  T get mb8 => this..marginBottom = 8.r;

  T get mb10 => this..marginBottom = 10.r;

  T get mb12 => this..marginBottom = 12.r;

  T get mb14 => this..marginBottom = 14.r;

  T get mb16 => this..marginBottom = 16.r;

  T get mb18 => this..marginBottom = 18.r;

  T get mb20 => this..marginBottom = 20.r;

  T get mb22 => this..marginBottom = 22.r;

  T get mb24 => this..marginBottom = 24.r;

  T get mb26 => this..marginBottom = 26.r;

  T get mb28 => this..marginBottom = 28.r;

  T get mb30 => this..marginBottom = 30.r;

  T get mb32 => this..marginBottom = 32.r;

  T get mh2 => this..marginHorizontal = 2.r;

  T get mh4 => this..marginHorizontal = 4.r;

  T get mh6 => this..marginHorizontal = 6.r;

  T get mh8 => this..marginHorizontal = 8.r;

  T get mh10 => this..marginHorizontal = 10.r;

  T get mh12 => this..marginHorizontal = 12.r;

  T get mh14 => this..marginHorizontal = 14.r;

  T get mh16 => this..marginHorizontal = 16.r;

  T get mh18 => this..marginHorizontal = 18.r;

  T get mh20 => this..marginHorizontal = 20.r;

  T get mh22 => this..marginHorizontal = 22.r;

  T get mh24 => this..marginHorizontal = 24.r;

  T get mh26 => this..marginHorizontal = 26.r;

  T get mh28 => this..marginHorizontal = 28.r;

  T get mh30 => this..marginHorizontal = 30.r;

  T get mh32 => this..marginHorizontal = 32.r;

  T get mv2 => this..marginVertical = 2.r;

  T get mv4 => this..marginVertical = 4.r;

  T get mv6 => this..marginVertical = 6.r;

  T get mv8 => this..marginVertical = 8.r;

  T get mv10 => this..marginVertical = 10.r;

  T get mv12 => this..marginVertical = 12.r;

  T get mv14 => this..marginVertical = 14.r;

  T get mv16 => this..marginVertical = 16.r;

  T get mv18 => this..marginVertical = 18.r;

  T get mv20 => this..marginVertical = 20.r;

  T get mv22 => this..marginVertical = 22.r;

  T get mv24 => this..marginVertical = 24.r;

  T get mv26 => this..marginVertical = 26.r;

  T get mv28 => this..marginVertical = 28.r;

  T get mv30 => this..marginVertical = 30.r;

  T get mv32 => this..marginVertical = 32.r;
}
