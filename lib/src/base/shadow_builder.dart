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
        color: Color(0x0D000000), // 相当于 Colors.black.withOpacity(0.05)
        offset: Offset(0, 1),
        blurRadius: 2.0,
        spreadRadius: 0.0,
      )
    ];

  ///2. Tailwind shadow-md
  T get shadowMd => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x1A000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(0, 4),
        blurRadius: 6.0,
        spreadRadius: 0.0,
      )
    ];

  ///3. Tailwind shadow-lg
  T get shadowLg => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x1A000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(0, 10),
        blurRadius: 15.0,
        spreadRadius: -3.0,
      )
    ];

  ///4. Tailwind shadow-xl
  T get shadowXl => this
    ..boxShadow = const [
      BoxShadow(
        color: Color(0x1A000000), // 相当于 Colors.black.withOpacity(0.1)
        offset: Offset(0, 20),
        blurRadius: 25.0,
        spreadRadius: -5.0,
      )
    ];
}
