import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/24
/// describe:
mixin ShadowBuilder {
  List<BoxShadow>? boxShadow;

  /// 阴影不做 ScreenUtil(sr) 缩放，直接使用固定 px —— 与 web Tailwind 像素级一致。
  List<BoxShadow>? get adaptedBoxShadow => boxShadow;
}

extension ShadowBuilderExt<T extends ShadowBuilder> on T {
  T shadow(List<BoxShadow> boxShadow) {
    this.boxShadow = boxShadow;
    return this;
  }

  // 说明：以下预设完全对齐 Tailwind CSS 官方 box-shadow（竖直偏移、低透明度黑）。
  // 颜色 alpha 换算：0.05→0x0D、0.1→0x1A、0.25→0x40。多数层级为双层叠加，更柔和自然。

  /// 柔和卡片阴影（介于 shadow / shadow-md 之间的轻阴影）
  T get cardShadow => this
    ..boxShadow = const [
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 2),
          blurRadius: 8,
          spreadRadius: -2),
    ];

  /// Tailwind `shadow-sm`: 0 1px 2px 0 rgb(0 0 0 / 0.05)
  T get shadowSm => this
    ..boxShadow = const [
      BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
    ];

  /// Tailwind `shadow` (DEFAULT): 0 1px 3px 0/.1, 0 1px 2px -1px/.1
  T get shadowBase => this
    ..boxShadow = const [
      BoxShadow(color: Color(0x1A000000), offset: Offset(0, 1), blurRadius: 3),
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: -1),
    ];

  /// Tailwind `shadow-md`: 0 4px 6px -1px/.1, 0 2px 4px -2px/.1
  T get shadowMd => this
    ..boxShadow = const [
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 4),
          blurRadius: 6,
          spreadRadius: -1),
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: -2),
    ];

  /// Tailwind `shadow-lg`: 0 10px 15px -3px/.1, 0 4px 6px -4px/.1
  T get shadowLg => this
    ..boxShadow = const [
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 10),
          blurRadius: 15,
          spreadRadius: -3),
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 4),
          blurRadius: 6,
          spreadRadius: -4),
    ];

  /// Tailwind `shadow-xl`: 0 20px 25px -5px/.1, 0 8px 10px -6px/.1
  T get shadowXl => this
    ..boxShadow = const [
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 20),
          blurRadius: 25,
          spreadRadius: -5),
      BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 8),
          blurRadius: 10,
          spreadRadius: -6),
    ];

  /// Tailwind `shadow-2xl`: 0 25px 50px -12px rgb(0 0 0 / 0.25)
  T get shadow2xl => this
    ..boxShadow = const [
      BoxShadow(
          color: Color(0x40000000),
          offset: Offset(0, 25),
          blurRadius: 50,
          spreadRadius: -12),
    ];
}
