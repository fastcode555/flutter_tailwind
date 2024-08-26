import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin PaddingBuilder {
  double? paddingValue;
  double? paddingLeft;
  double? paddingRight;
  double? paddingTop;
  double? paddingBottom;

  double? paddingHorizontal;
  double? paddingVertical;

  EdgeInsetsGeometry? _innerPadding;

  bool get hasPadding =>
      _innerPadding != null ||
      paddingValue != null ||
      paddingHorizontal != null ||
      paddingVertical != null ||
      paddingLeft != null ||
      paddingRight != null ||
      paddingTop != null ||
      paddingBottom != null;

  EdgeInsetsGeometry? get finalPadding {
    if (_innerPadding != null) return _innerPadding;
    if (hasPadding) {
      return EdgeInsets.only(
        left: paddingLeft ?? paddingHorizontal ?? paddingValue ?? 0.0,
        right: paddingRight ?? paddingHorizontal ?? paddingValue ?? 0.0,
        top: paddingTop ?? paddingVertical ?? paddingValue ?? 0.0,
        bottom: paddingBottom ?? paddingVertical ?? paddingValue ?? 0.0,
      );
    }
    return null;
  }
}

extension PaddingBuilderExt<T extends PaddingBuilder> on T {
  T padding(EdgeInsetsGeometry? padding) => this.._innerPadding = padding;

  T get p2 => this..paddingValue = 2.r;

  T get p4 => this..paddingValue = 4.r;

  T get p6 => this..paddingValue = 6.r;

  T get p8 => this..paddingValue = 8.r;

  T get p10 => this..paddingValue = 10.r;

  T get p12 => this..paddingValue = 12.r;

  T get p14 => this..paddingValue = 14.r;

  T get p16 => this..paddingValue = 16.r;

  T get p18 => this..paddingValue = 18.r;

  T get p20 => this..paddingValue = 20.r;

  T get p22 => this..paddingValue = 22.r;

  T get p24 => this..paddingValue = 24.r;

  T get p26 => this..paddingValue = 26.r;

  T get p28 => this..paddingValue = 28.r;

  T get p30 => this..paddingValue = 30.r;

  T get p32 => this..paddingValue = 32.r;

  T get pl2 => this..paddingLeft = 2.r;

  T get pl4 => this..paddingLeft = 4.r;

  T get pl6 => this..paddingLeft = 6.r;

  T get pl8 => this..paddingLeft = 8.r;

  T get pl10 => this..paddingLeft = 10.r;

  T get pl12 => this..paddingLeft = 12.r;

  T get pl14 => this..paddingLeft = 14.r;

  T get pl16 => this..paddingLeft = 16.r;

  T get pl18 => this..paddingLeft = 18.r;

  T get pl20 => this..paddingLeft = 20.r;

  T get pl22 => this..paddingLeft = 22.r;

  T get pl24 => this..paddingLeft = 24.r;

  T get pl26 => this..paddingLeft = 26.r;

  T get pl28 => this..paddingLeft = 28.r;

  T get pl30 => this..paddingLeft = 30.r;

  T get pl32 => this..paddingLeft = 32.r;

  T get pr2 => this..paddingRight = 2.r;

  T get pr4 => this..paddingRight = 4.r;

  T get pr6 => this..paddingRight = 6.r;

  T get pr8 => this..paddingRight = 8.r;

  T get pr10 => this..paddingRight = 10.r;

  T get pr12 => this..paddingRight = 12.r;

  T get pr14 => this..paddingRight = 14.r;

  T get pr16 => this..paddingRight = 16.r;

  T get pr18 => this..paddingRight = 18.r;

  T get pr20 => this..paddingRight = 20.r;

  T get pr22 => this..paddingRight = 22.r;

  T get pr24 => this..paddingRight = 24.r;

  T get pr26 => this..paddingRight = 26.r;

  T get pr28 => this..paddingRight = 28.r;

  T get pr30 => this..paddingRight = 30.r;

  T get pr32 => this..paddingRight = 32.r;

  T get pt2 => this..paddingTop = 2.r;

  T get pt4 => this..paddingTop = 4.r;

  T get pt6 => this..paddingTop = 6.r;

  T get pt8 => this..paddingTop = 8.r;

  T get pt10 => this..paddingTop = 10.r;

  T get pt12 => this..paddingTop = 12.r;

  T get pt14 => this..paddingTop = 14.r;

  T get pt16 => this..paddingTop = 16.r;

  T get pt18 => this..paddingTop = 18.r;

  T get pt20 => this..paddingTop = 20.r;

  T get pt22 => this..paddingTop = 22.r;

  T get pt24 => this..paddingTop = 24.r;

  T get pt26 => this..paddingTop = 26.r;

  T get pt28 => this..paddingTop = 28.r;

  T get pt30 => this..paddingTop = 30.r;

  T get pt32 => this..paddingTop = 32.r;

  T get pb2 => this..paddingBottom = 2.r;

  T get pb4 => this..paddingBottom = 4.r;

  T get pb6 => this..paddingBottom = 6.r;

  T get pb8 => this..paddingBottom = 8.r;

  T get pb10 => this..paddingBottom = 10.r;

  T get pb12 => this..paddingBottom = 12.r;

  T get pb14 => this..paddingBottom = 14.r;

  T get pb16 => this..paddingBottom = 16.r;

  T get pb18 => this..paddingBottom = 18.r;

  T get pb20 => this..paddingBottom = 20.r;

  T get pb22 => this..paddingBottom = 22.r;

  T get pb24 => this..paddingBottom = 24.r;

  T get pb26 => this..paddingBottom = 26.r;

  T get pb28 => this..paddingBottom = 28.r;

  T get pb30 => this..paddingBottom = 30.r;

  T get pb32 => this..paddingBottom = 32.r;

  T get ph2 => this..paddingHorizontal = 2.r;

  T get ph4 => this..paddingHorizontal = 4.r;

  T get ph6 => this..paddingHorizontal = 6.r;

  T get ph8 => this..paddingHorizontal = 8.r;

  T get ph10 => this..paddingHorizontal = 10.r;

  T get ph12 => this..paddingHorizontal = 12.r;

  T get ph14 => this..paddingHorizontal = 14.r;

  T get ph16 => this..paddingHorizontal = 16.r;

  T get ph18 => this..paddingHorizontal = 18.r;

  T get ph20 => this..paddingHorizontal = 20.r;

  T get ph22 => this..paddingHorizontal = 22.r;

  T get ph24 => this..paddingHorizontal = 24.r;

  T get ph26 => this..paddingHorizontal = 26.r;

  T get ph28 => this..paddingHorizontal = 28.r;

  T get ph30 => this..paddingHorizontal = 30.r;

  T get ph32 => this..paddingHorizontal = 32.r;

  T get pv2 => this..paddingVertical = 2.r;

  T get pv4 => this..paddingVertical = 4.r;

  T get pv6 => this..paddingVertical = 6.r;

  T get pv8 => this..paddingVertical = 8.r;

  T get pv10 => this..paddingVertical = 10.r;

  T get pv12 => this..paddingVertical = 12.r;

  T get pv14 => this..paddingVertical = 14.r;

  T get pv16 => this..paddingVertical = 16.r;

  T get pv18 => this..paddingVertical = 18.r;

  T get pv20 => this..paddingVertical = 20.r;

  T get pv22 => this..paddingVertical = 22.r;

  T get pv24 => this..paddingVertical = 24.r;

  T get pv26 => this..paddingVertical = 26.r;

  T get pv28 => this..paddingVertical = 28.r;

  T get pv30 => this..paddingVertical = 30.r;

  T get pv32 => this..paddingVertical = 32.r;
}
