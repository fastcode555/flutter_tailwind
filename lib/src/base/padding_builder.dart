import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin PaddingBuilder {
  EdgeInsetsGeometry? innerPadding;
}

extension PaddingBuilderExt<T extends PaddingBuilder> on T {
  T padding(EdgeInsetsGeometry? padding) => this..innerPadding = padding;

  T get p2 => this..innerPadding = REdgeInsets.all(2);

  T get p4 => this..innerPadding = REdgeInsets.all(4);

  T get p6 => this..innerPadding = REdgeInsets.all(6);

  T get p8 => this..innerPadding = REdgeInsets.all(8);

  T get p10 => this..innerPadding = REdgeInsets.all(10);

  T get p12 => this..innerPadding = REdgeInsets.all(12);

  T get p14 => this..innerPadding = REdgeInsets.all(14);

  T get p16 => this..innerPadding = REdgeInsets.all(16);

  T get p18 => this..innerPadding = REdgeInsets.all(18);

  T get p20 => this..innerPadding = REdgeInsets.all(20);

  T get p22 => this..innerPadding = REdgeInsets.all(22);

  T get p24 => this..innerPadding = REdgeInsets.all(24);

  T get p26 => this..innerPadding = REdgeInsets.all(26);

  T get p28 => this..innerPadding = REdgeInsets.all(28);

  T get p30 => this..innerPadding = REdgeInsets.all(30);

  T get p32 => this..innerPadding = REdgeInsets.all(32);
}
