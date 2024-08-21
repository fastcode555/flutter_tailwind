import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/19
/// describe:
mixin BoxFitBuilder {
  BoxFit? fit;
}

extension BoxFitBuilderExt<T extends BoxFitBuilder> on T {
  T get fill => this..fit = BoxFit.fill;

  T get contain => this..fit = BoxFit.contain;

  T get cover => this..fit = BoxFit.cover;

  T get fitWidth => this..fit = BoxFit.fitWidth;

  T get fitHeight => this..fit = BoxFit.fitHeight;

  T get none => this..fit = BoxFit.none;

  T get scaleDown => this..fit = BoxFit.scaleDown;
}
