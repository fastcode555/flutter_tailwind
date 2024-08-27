import 'package:example/res/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

import 'colours.dart';

part 'tailwind_ext.g.dart';

extension TextFeaturpExt<T extends TextFeature> on T {
  T get conther => this..fontFamily = R.conther2;
}

extension DecorationExt<T extends CompleteDecoration> on T {
  T get decorMain => this..decoration = bd.greenAccent.borderBrown.rounded8.border5.mk;

  T get decorTradition => this
    ..decoration = BoxDecoration(
      color: Colors.greenAccent,
      border: Border.all(color: Colors.brown, width: 5.r),
      borderRadius: BorderRadius.circular(8.r),
    );
}

extension TextStyleExt<T extends CompletedTextStyleBuilder> on T {
  T get styleMain => this..style = ts.redAccent.f16.bold.underline.mk;

  T get styleAccent => this..style = ts.greenAccent.f20.bold.lineColor.mk;

  T get styleTest => this..style = ts.dashed.lightGreen.f30.bold.lineThrough.mk;
}

extension SizeExt<T extends SizeBuilder> on T {
  T get h200 => this..height = 200.h;

  T get w200 => this..width = 200.w;

  T get s200 => this..size = 200.r;

  T get s300 => this..size = 300.r;

  T get s121 => this..size = 121.r;
}
