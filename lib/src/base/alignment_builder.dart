import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/20
/// describe:
mixin AlignmentBuilder {
  Alignment? alignment;
}

extension AlignmentBuilderExt<T extends AlignmentBuilder> on T {
  T get topLeft => this..alignment = Alignment.topLeft;

  T get topCenter => this..alignment = Alignment.topCenter;

  T get topRight => this..alignment = Alignment.topRight;

  T get centerLeft => this..alignment = Alignment.centerLeft;

  T get center => this..alignment = Alignment.center;

  T get centerRight => this..alignment = Alignment.centerRight;

  T get bottomLeft => this..alignment = Alignment.bottomLeft;

  T get bottomCenter => this..alignment = Alignment.bottomCenter;

  T get bottomRight => this..alignment = Alignment.bottomRight;
}
