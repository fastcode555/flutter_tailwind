import 'dart:ui';

/// Barry
/// @date 2024/9/4
/// describe:

extension ColorOptionalOpacityExt on Color? {
  Color? opacity(double? opacity) {
    if (this == null || opacity == null || opacity == 1.0 || opacity < 0) return this;
    return this?.withOpacity(opacity);
  }
}

extension ColorOpacityExt<T extends Color> on T {
  T get opacity10 => this..withOpacity(0.1);

  T get opacity15 => this..withOpacity(0.15);

  T get opacity20 => this..withOpacity(0.2);

  T get opacity25 => this..withOpacity(0.25);

  T get opacity30 => this..withOpacity(0.3);

  T get opacity35 => this..withOpacity(0.35);

  T get opacity40 => this..withOpacity(0.4);

  T get opacity45 => this..withOpacity(0.45);

  T get opacity50 => this..withOpacity(0.5);

  T get opacity55 => this..withOpacity(0.55);

  T get opacity60 => this..withOpacity(0.6);

  T get opacity65 => this..withOpacity(0.65);

  T get opacity70 => this..withOpacity(0.7);

  T get opacity75 => this..withOpacity(0.75);

  T get opacity80 => this..withOpacity(0.8);

  T get opacity85 => this..withOpacity(0.85);

  T get opacity90 => this..withOpacity(0.9);

  T get opacity95 => this..withOpacity(0.95);
}

mixin OpacityBuilder {
  double? innerOpacity;
}

extension OpacityBuilderExt<T extends OpacityBuilder> on T {
  T opacity(double opacity) => this..innerOpacity = opacity;

  T get opacity10 => this..opacity(0.1);

  T get opacity15 => this..opacity(0.15);

  T get opacity20 => this..opacity(0.2);

  T get opacity25 => this..opacity(0.25);

  T get opacity30 => this..opacity(0.3);

  T get opacity35 => this..opacity(0.35);

  T get opacity40 => this..opacity(0.4);

  T get opacity45 => this..opacity(0.45);

  T get opacity50 => this..opacity(0.5);

  T get opacity55 => this..opacity(0.55);

  T get opacity60 => this..opacity(0.6);

  T get opacity65 => this..opacity(0.65);

  T get opacity70 => this..opacity(0.7);

  T get opacity75 => this..opacity(0.75);

  T get opacity80 => this..opacity(0.8);

  T get opacity85 => this..opacity(0.85);

  T get opacity90 => this..opacity(0.9);

  T get opacity95 => this..opacity(0.95);
}
