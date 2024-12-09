import 'package:flutter/material.dart';

/// Barry
/// @date 2024/12/9
/// describe:
mixin VerticalDirectionBuilder {
  VerticalDirection? verticalDirection;
}

extension VerticalDirectionBuilderExt<T extends VerticalDirectionBuilder> on T {
  /// vertical direction
  T get down => this..verticalDirection = VerticalDirection.down;

  T get up => this..verticalDirection = VerticalDirection.up;
}
