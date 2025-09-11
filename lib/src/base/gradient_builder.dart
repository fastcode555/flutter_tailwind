import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/24
/// describe:
mixin GradientBuilder {
  Gradient? innerGradient;
}

extension GradientBuilderExt<T extends GradientBuilder> on T {
  T gradient(Gradient? gradient) {
    this.innerGradient = gradient;
    return this;
  }
}
