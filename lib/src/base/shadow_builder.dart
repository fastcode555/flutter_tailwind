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

  ///1. Tailwind shadow-sm
  T get shadowSm => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x4D000000), // 相当于 Colors.black.withOpacity(0.05)
        offset: Offset(0, 2),
        blurRadius: 2.0,
      )
    ];

  ///2. Tailwind shadow-md
  T get shadowMd => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x4D000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(4, 4),
        blurRadius: 4.0,
      )
    ];

  ///3. Tailwind shadow-lg
  T get shadowLg => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x4D000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(8, 8),
        blurRadius: 8.0,
        spreadRadius: -3.0,
      )
    ];

  ///4. Tailwind shadow-xl
  T get shadowXl => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x4D000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(12, 12),
        blurRadius: 12.0,
        spreadRadius: -5.0,
      )
    ];
}
