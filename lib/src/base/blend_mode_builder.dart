import 'package:flutter/material.dart';

/// Barry
/// @date 7/11/23
/// describe:
mixin BlendModeBuilder {
  BlendMode? innerBlendMode;
}

extension BlendModeBuilderExt<T extends BlendModeBuilder> on T {
  ///[BlendMode.clear]
  T blendMode(BlendMode blendMode) => this..innerBlendMode = blendMode;

  ///[BlendMode.clear]
  T get clear => this..innerBlendMode = BlendMode.clear;

  ///[BlendMode.src]
  T get src => this..innerBlendMode = BlendMode.src;

  ///[BlendMode.dst]
  T get dst => this..innerBlendMode = BlendMode.dst;

  ///[BlendMode.srcOver]
  T get srcOver => this..innerBlendMode = BlendMode.srcOver;

  ///[BlendMode.dstOver]
  T get dstOver => this..innerBlendMode = BlendMode.dstOver;

  ///[BlendMode.srcIn]
  T get srcIn => this..innerBlendMode = BlendMode.srcIn;

  ///[BlendMode.dstIn]
  T get dstIn => this..innerBlendMode = BlendMode.dstIn;

  ///[BlendMode.srcOut]
  T get srcOut => this..innerBlendMode = BlendMode.srcOut;

  ///[BlendMode.dstOut]
  T get dstOut => this..innerBlendMode = BlendMode.dstOut;

  ///[BlendMode.srcATop]
  T get srcATop => this..innerBlendMode = BlendMode.srcATop;

  ///[BlendMode.dstATop]
  T get dstATop => this..innerBlendMode = BlendMode.dstATop;

  ///[BlendMode.xor]
  T get xor => this..innerBlendMode = BlendMode.xor;

  ///[BlendMode.plus]
  T get plus => this..innerBlendMode = BlendMode.plus;

  ///[BlendMode.modulate]
  T get modulate => this..innerBlendMode = BlendMode.modulate;

  ///[BlendMode.screen]
  T get screen => this..innerBlendMode = BlendMode.screen;

  ///[BlendMode.overlay]
  T get overlay => this..innerBlendMode = BlendMode.overlay;

  ///[BlendMode.darken]
  T get darken => this..innerBlendMode = BlendMode.darken;

  ///[BlendMode.lighten]
  T get lighten => this..innerBlendMode = BlendMode.lighten;

  ///[BlendMode.colorDodge]
  T get colorDodge => this..innerBlendMode = BlendMode.colorDodge;

  ///[BlendMode.colorBurn]
  T get colorBurn => this..innerBlendMode = BlendMode.colorBurn;

  ///[BlendMode.hardLight]
  T get hardLight => this..innerBlendMode = BlendMode.hardLight;

  ///[BlendMode.softLight]
  T get softLight => this..innerBlendMode = BlendMode.softLight;

  ///[BlendMode.difference]
  T get difference => this..innerBlendMode = BlendMode.difference;

  ///[BlendMode.exclusion]
  T get exclusion => this..innerBlendMode = BlendMode.exclusion;

  ///[BlendMode.multiply]
  T get multiply => this..innerBlendMode = BlendMode.multiply;

  ///[BlendMode.hue]
  T get hue => this..innerBlendMode = BlendMode.hue;

  ///[BlendMode.saturation]
  T get saturation => this..innerBlendMode = BlendMode.saturation;

  ///[BlendMode.color]
  T get colorBlendMode => this..innerBlendMode = BlendMode.color;

  ///[BlendMode.luminosity]
  T get luminosity => this..innerBlendMode = BlendMode.luminosity;
}
