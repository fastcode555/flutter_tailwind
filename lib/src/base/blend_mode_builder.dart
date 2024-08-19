import 'dart:ui';

/// @date 7/11/23
/// describe:
mixin BlendModeBuilder {
  BlendMode? _backgroundBlendMode;

  BlendMode? get backgroundBlendMode => _backgroundBlendMode;

  set backgroundBlendMode(BlendMode? backgroundBlendMode) {
    _backgroundBlendMode = backgroundBlendMode;
  }
}

extension BlendModeBuilderExt<T extends BlendModeBuilder> on T {
  T get clear => this.._backgroundBlendMode = BlendMode.clear;

  T get src => this.._backgroundBlendMode = BlendMode.src;

  T get dst => this.._backgroundBlendMode = BlendMode.dst;

  T get srcOver => this.._backgroundBlendMode = BlendMode.srcOver;

  T get dstOver => this.._backgroundBlendMode = BlendMode.dstOver;

  T get srcIn => this.._backgroundBlendMode = BlendMode.srcIn;

  T get dstIn => this.._backgroundBlendMode = BlendMode.dstIn;

  T get srcOut => this.._backgroundBlendMode = BlendMode.srcOut;

  T get dstOut => this.._backgroundBlendMode = BlendMode.dstOut;

  T get srcATop => this.._backgroundBlendMode = BlendMode.srcATop;

  T get dstATop => this.._backgroundBlendMode = BlendMode.dstATop;

  T get xor => this.._backgroundBlendMode = BlendMode.xor;

  T get plus => this.._backgroundBlendMode = BlendMode.plus;

  T get modulate => this.._backgroundBlendMode = BlendMode.modulate;

  T get screen => this.._backgroundBlendMode = BlendMode.screen;

  T get overlay => this.._backgroundBlendMode = BlendMode.overlay;

  T get darken => this.._backgroundBlendMode = BlendMode.darken;

  T get lighten => this.._backgroundBlendMode = BlendMode.lighten;

  T get colorDodge => this.._backgroundBlendMode = BlendMode.colorDodge;

  T get colorBurn => this.._backgroundBlendMode = BlendMode.colorBurn;

  T get hardLight => this.._backgroundBlendMode = BlendMode.hardLight;

  T get softLight => this.._backgroundBlendMode = BlendMode.softLight;

  T get difference => this.._backgroundBlendMode = BlendMode.difference;

  T get exclusion => this.._backgroundBlendMode = BlendMode.exclusion;

  T get multiply => this.._backgroundBlendMode = BlendMode.multiply;

  T get hue => this.._backgroundBlendMode = BlendMode.hue;

  T get saturation => this.._backgroundBlendMode = BlendMode.saturation;

  T get color => this.._backgroundBlendMode = BlendMode.color;

  T get luminosity => this.._backgroundBlendMode = BlendMode.luminosity;
}
