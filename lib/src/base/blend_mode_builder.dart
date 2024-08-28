import 'package:flutter/material.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin BlendModeBuilder {
  BlendMode? blendMode;
}

extension BlendModeBuilderExt<T extends BlendModeBuilder> on T {
  T get clear => this..blendMode = BlendMode.clear;

  T get src => this..blendMode = BlendMode.src;

  T get dst => this..blendMode = BlendMode.dst;

  T get srcOver => this..blendMode = BlendMode.srcOver;

  T get dstOver => this..blendMode = BlendMode.dstOver;

  T get srcIn => this..blendMode = BlendMode.srcIn;

  T get dstIn => this..blendMode = BlendMode.dstIn;

  T get srcOut => this..blendMode = BlendMode.srcOut;

  T get dstOut => this..blendMode = BlendMode.dstOut;

  T get srcATop => this..blendMode = BlendMode.srcATop;

  T get dstATop => this..blendMode = BlendMode.dstATop;

  T get xor => this..blendMode = BlendMode.xor;

  T get plus => this..blendMode = BlendMode.plus;

  T get modulate => this..blendMode = BlendMode.modulate;

  T get screen => this..blendMode = BlendMode.screen;

  T get overlay => this..blendMode = BlendMode.overlay;

  T get darken => this..blendMode = BlendMode.darken;

  T get lighten => this..blendMode = BlendMode.lighten;

  T get colorDodge => this..blendMode = BlendMode.colorDodge;

  T get colorBurn => this..blendMode = BlendMode.colorBurn;

  T get hardLight => this..blendMode = BlendMode.hardLight;

  T get softLight => this..blendMode = BlendMode.softLight;

  T get difference => this..blendMode = BlendMode.difference;

  T get exclusion => this..blendMode = BlendMode.exclusion;

  T get multiply => this..blendMode = BlendMode.multiply;

  T get hue => this..blendMode = BlendMode.hue;

  T get saturation => this..blendMode = BlendMode.saturation;

  T get color => this..blendMode = BlendMode.color;

  T get luminosity => this..blendMode = BlendMode.luminosity;
}
