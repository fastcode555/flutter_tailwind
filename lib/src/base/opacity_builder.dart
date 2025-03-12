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
  /// get the color [Color.withOpacity] 0.05
  Color get opacity5 => this.withOpacity(0.05);

  /// get the color [Color.withOpacity] 0.1
  Color get opacity10 => this.withOpacity(0.1);

  /// get the color [Color.withOpacity] 0.15
  Color get opacity15 => this.withOpacity(0.15);

  /// get the color [Color.withOpacity] 0.2
  Color get opacity20 => this.withOpacity(0.2);

  /// get the color [Color.withOpacity] 0.25
  Color get opacity25 => this.withOpacity(0.25);

  /// get the color [Color.withOpacity] 0.3
  Color get opacity30 => this.withOpacity(0.3);

  /// get the color [Color.withOpacity] 0.35
  Color get opacity35 => this.withOpacity(0.35);

  /// get the color [Color.withOpacity] 0.4
  Color get opacity40 => this.withOpacity(0.4);

  /// get the color [Color.withOpacity] 0.45
  Color get opacity45 => this.withOpacity(0.45);

  /// get the color [Color.withOpacity] 0.5
  Color get opacity50 => this.withOpacity(0.5);

  /// get the color [Color.withOpacity] 0.55
  Color get opacity55 => this.withOpacity(0.55);

  /// get the color [Color.withOpacity] 0.6
  Color get opacity60 => this.withOpacity(0.6);

  /// get the color [Color.withOpacity] 0.65
  Color get opacity65 => this.withOpacity(0.65);

  /// get the color [Color.withOpacity] 0.7
  Color get opacity70 => this.withOpacity(0.7);

  /// get the color [Color.withOpacity] 0.75
  Color get opacity75 => this.withOpacity(0.75);

  /// get the color [Color.withOpacity] 0.8
  Color get opacity80 => this.withOpacity(0.8);

  /// get the color [Color.withOpacity] 0.85
  Color get opacity85 => this.withOpacity(0.85);

  /// get the color [Color.withOpacity] 0.9
  Color get opacity90 => this.withOpacity(0.9);

  /// get the color [Color.withOpacity] 0.95
  Color get opacity95 => this.withOpacity(0.95);
}

mixin OpacityBuilder {
  double? innerOpacity;
}

extension OpacityBuilderExt<T extends OpacityBuilder> on T {
  T opacity(double opacity) => this..innerOpacity = opacity;

  /// set the opacity value is 0.05
  T get opacity5 => this..opacity(0.05);

  /// set the opacity value is 0.1
  T get opacity10 => this..opacity(0.1);

  /// set the opacity value is 0.15
  T get opacity15 => this..opacity(0.15);

  /// set the opacity value is 0.2
  T get opacity20 => this..opacity(0.2);

  /// set the opacity value is 0.25
  T get opacity25 => this..opacity(0.25);

  /// set the opacity value is 0.3
  T get opacity30 => this..opacity(0.3);

  /// set the opacity value is 0.35
  T get opacity35 => this..opacity(0.35);

  /// set the opacity value is 0.4
  T get opacity40 => this..opacity(0.4);

  /// set the opacity value is 0.45
  T get opacity45 => this..opacity(0.45);

  /// set the opacity value is 0.5
  T get opacity50 => this..opacity(0.5);

  /// set the opacity value is 0.55
  T get opacity55 => this..opacity(0.55);

  /// set the opacity value is 0.6
  T get opacity60 => this..opacity(0.6);

  /// set the opacity value is 0.65
  T get opacity65 => this..opacity(0.65);

  /// set the opacity value is 0.7
  T get opacity70 => this..opacity(0.7);

  /// set the opacity value is 0.75
  T get opacity75 => this..opacity(0.75);

  /// set the opacity value is 0.8
  T get opacity80 => this..opacity(0.8);

  /// set the opacity value is 0.85
  T get opacity85 => this..opacity(0.85);

  /// set the opacity value is 0.9
  T get opacity90 => this..opacity(0.9);

  /// set the opacity value is 0.95
  T get opacity95 => this..opacity(0.95);
}
