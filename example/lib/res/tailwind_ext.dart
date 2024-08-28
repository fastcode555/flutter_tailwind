import 'package:example/res/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

import 'colours.dart';

part 'tailwind_ext.g.dart';

/// define the custom size here
extension SizeExt<T extends SizeBuilder> on T {
  T get h200 => this..height = 200.h;

  T get h365 => this..height = 365.h;

  T get w200 => this..width = 200.w;

  T get s200 => this..size = 200.r;

  T get s300 => this..size = 300.r;

  T get s121 => this..size = 121.r;
}

/// define the custom text feature here
extension TextFeatureExt<T extends TextFeature> on T {
  T get conther => this..fontFamily = R.conther;
}

/// define the custom text style here,text feature just single feature,but style is completed style,can directly use it
extension TextStyleExt<T extends CompletedTextStyleBuilder> on T {
  T get styleMain => this..style = ts.redAccent.f16.bold.underline.mk;

  /// use flutter tailwind style
  T get styleAccent => this..style = ts.greenAccent.f20.bold.underline.mk;

  T get styleTest => this..style = ts.dashed.lightGreen.f30.bold.lineThrough.mk;

  /// use flutter normal style to describe text style
  T get styleTradition => this
    ..style = TextStyle(
      color: Colors.greenAccent,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
}

/// define the shadow
extension ShadowExt<T extends ShadowBuilder> on T {
  T get customShadow => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x78000000),
        offset: Offset(0, 4),
        blurRadius: 4.0,
        spreadRadius: 0.0,
      )
    ];
}

/// You can define the default style which just explain you how to define the style with flutter tailwind
extension DecorationExt<T extends CompleteDecoration> on T {
  /// use flutter tailwind BoxDecoration
  T get decorMain => this..decoration = bd.greenAccent.circle.borderBrown.customShadow.border5.mk;

  /// Use flutter normal style to describe BoxDecoration
  T get decorTradition => this
    ..decoration = BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(color: Colors.brown, width: 5.r),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x78000000),
            offset: Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),
        ]);
}
