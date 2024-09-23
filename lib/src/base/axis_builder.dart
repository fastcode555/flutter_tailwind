import 'package:flutter/material.dart';

/// Barry
/// @date 2024/9/21
/// describe:
mixin AxisBuilder {
  Axis? direction;
}

extension AxisBuilderExt<T extends AxisBuilder> on T {
  T get vertical => this..direction = Axis.vertical;

  T get horizontal => this..direction = Axis.horizontal;
}
