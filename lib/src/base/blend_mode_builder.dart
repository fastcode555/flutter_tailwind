import 'package:flutter/material.dart';

/// @date 7/11/23
/// describe:
mixin BlendModeBuilder {
  BlendMode? backgroundBlendMode;
}

extension BlendModeBuilderExt<T extends BlendModeBuilder> on T {
  T get clear => this..backgroundBlendMode = BlendMode.clear;

  T get src => this..backgroundBlendMode = BlendMode.src;

  T get dst => this..backgroundBlendMode = BlendMode.dst;

  T get srcOver => this..backgroundBlendMode = BlendMode.srcOver;

  T get dstOver => this..backgroundBlendMode = BlendMode.dstOver;

  T get srcIn => this..backgroundBlendMode = BlendMode.srcIn;

  T get dstIn => this..backgroundBlendMode = BlendMode.dstIn;

  T get srcOut => this..backgroundBlendMode = BlendMode.srcOut;

  T get dstOut => this..backgroundBlendMode = BlendMode.dstOut;

  T get srcATop => this..backgroundBlendMode = BlendMode.srcATop;

  T get dstATop => this..backgroundBlendMode = BlendMode.dstATop;

  T get xor => this..backgroundBlendMode = BlendMode.xor;

  T get plus => this..backgroundBlendMode = BlendMode.plus;

  T get modulate => this..backgroundBlendMode = BlendMode.modulate;

  T get screen => this..backgroundBlendMode = BlendMode.screen;

  T get overlay => this..backgroundBlendMode = BlendMode.overlay;

  T get darken => this..backgroundBlendMode = BlendMode.darken;

  T get lighten => this..backgroundBlendMode = BlendMode.lighten;

  T get colorDodge => this..backgroundBlendMode = BlendMode.colorDodge;

  T get colorBurn => this..backgroundBlendMode = BlendMode.colorBurn;

  T get hardLight => this..backgroundBlendMode = BlendMode.hardLight;

  T get softLight => this..backgroundBlendMode = BlendMode.softLight;

  T get difference => this..backgroundBlendMode = BlendMode.difference;

  T get exclusion => this..backgroundBlendMode = BlendMode.exclusion;

  T get multiply => this..backgroundBlendMode = BlendMode.multiply;

  T get hue => this..backgroundBlendMode = BlendMode.hue;

  T get saturation => this..backgroundBlendMode = BlendMode.saturation;

  T get color => this..backgroundBlendMode = BlendMode.color;

  T get luminosity => this..backgroundBlendMode = BlendMode.luminosity;
}
