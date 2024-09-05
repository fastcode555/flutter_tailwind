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

  T get p34 => this..paddingValue = 34.r;

  T get p36 => this..paddingValue = 36.r;

  T get p38 => this..paddingValue = 38.r;

  T get p40 => this..paddingValue = 40.r;

  T get p42 => this..paddingValue = 42.r;

  T get p44 => this..paddingValue = 44.r;

  T get p46 => this..paddingValue = 46.r;

  T get p48 => this..paddingValue = 48.r;

  T get p50 => this..paddingValue = 50.r;

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

  T get pl34 => this..paddingLeft = 34.r;

  T get pl36 => this..paddingLeft = 36.r;

  T get pl38 => this..paddingLeft = 38.r;

  T get pl40 => this..paddingLeft = 40.r;

  T get pl42 => this..paddingLeft = 42.r;

  T get pl44 => this..paddingLeft = 44.r;

  T get pl46 => this..paddingLeft = 46.r;

  T get pl48 => this..paddingLeft = 48.r;

  T get pl50 => this..paddingLeft = 50.r;

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

  T get pr34 => this..paddingRight = 34.r;

  T get pr36 => this..paddingRight = 36.r;

  T get pr38 => this..paddingRight = 38.r;

  T get pr40 => this..paddingRight = 40.r;

  T get pr42 => this..paddingRight = 42.r;

  T get pr44 => this..paddingRight = 44.r;

  T get pr46 => this..paddingRight = 46.r;

  T get pr48 => this..paddingRight = 48.r;

  T get pr50 => this..paddingRight = 50.r;

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

  T get pt34 => this..paddingTop = 34.r;

  T get pt36 => this..paddingTop = 36.r;

  T get pt38 => this..paddingTop = 38.r;

  T get pt40 => this..paddingTop = 40.r;

  T get pt42 => this..paddingTop = 42.r;

  T get pt44 => this..paddingTop = 44.r;

  T get pt46 => this..paddingTop = 46.r;

  T get pt48 => this..paddingTop = 48.r;

  T get pt50 => this..paddingTop = 50.r;

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

  T get pb34 => this..paddingBottom = 34.r;

  T get pb36 => this..paddingBottom = 36.r;

  T get pb38 => this..paddingBottom = 38.r;

  T get pb40 => this..paddingBottom = 40.r;

  T get pb42 => this..paddingBottom = 42.r;

  T get pb44 => this..paddingBottom = 44.r;

  T get pb46 => this..paddingBottom = 46.r;

  T get pb48 => this..paddingBottom = 48.r;

  T get pb50 => this..paddingBottom = 50.r;

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

  T get ph34 => this..paddingHorizontal = 34.r;

  T get ph36 => this..paddingHorizontal = 36.r;

  T get ph38 => this..paddingHorizontal = 38.r;

  T get ph40 => this..paddingHorizontal = 40.r;

  T get ph42 => this..paddingHorizontal = 42.r;

  T get ph44 => this..paddingHorizontal = 44.r;

  T get ph46 => this..paddingHorizontal = 46.r;

  T get ph48 => this..paddingHorizontal = 48.r;

  T get ph50 => this..paddingHorizontal = 50.r;

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

  T get pv34 => this..paddingVertical = 34.r;

  T get pv36 => this..paddingVertical = 36.r;

  T get pv38 => this..paddingVertical = 38.r;

  T get pv40 => this..paddingVertical = 40.r;

  T get pv42 => this..paddingVertical = 42.r;

  T get pv44 => this..paddingVertical = 44.r;

  T get pv46 => this..paddingVertical = 46.r;

  T get pv48 => this..paddingVertical = 48.r;

  T get pv50 => this..paddingVertical = 50.r;
}
