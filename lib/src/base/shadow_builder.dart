import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/24
/// describe:
mixin ShadowBuilder {
  List<BoxShadow>? boxShadow;
}

extension ShadowBuilderExt<T extends ShadowBuilder> on T {
  T get cardShadow => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(3, 3),
      ),
    ];
}
