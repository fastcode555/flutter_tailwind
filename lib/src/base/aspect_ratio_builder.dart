/// Barry
/// @date 2024/8/28
/// describe:
mixin AspectRatioBuilder {
  double? innerRatio;
}

extension AspectRatioBuilderExt<T extends AspectRatioBuilder> on T {
  /// aspect ratio ratio
  T ratio(double ratio) => this..innerRatio = ratio;

  /// aspect ratio 0.25
  T get ratio25 => this..innerRatio = 0.25;

  T get ratio30 => this..innerRatio = 0.30;

  T get ratio35 => this..innerRatio = 0.35;

  T get ratio40 => this..innerRatio = 0.40;

  T get ratio45 => this..innerRatio = 0.45;

  /// aspect ratio 0.50
  T get ratio50 => this..innerRatio = 0.50;

  T get ratio55 => this..innerRatio = 0.55;

  T get ratio60 => this..innerRatio = 0.60;

  T get ratio65 => this..innerRatio = 0.65;

  T get ratio70 => this..innerRatio = 0.70;

  /// aspect ratio 0.75
  T get ratio75 => this..innerRatio = 0.75;

  T get ratio80 => this..innerRatio = 0.80;

  T get ratio85 => this..innerRatio = 0.85;

  T get ratio90 => this..innerRatio = 0.90;

  T get ratio95 => this..innerRatio = 0.95;

  /// aspect ratio 1.0
  T get ratio100 => this..innerRatio = 1.0;

  /// aspect ratio 1.25
  T get ratio125 => this..innerRatio = 1.25;

  /// aspect ratio 1.50
  T get ratio150 => this..innerRatio = 1.50;

  /// aspect ratio 1.75
  T get ratio175 => this..innerRatio = 1.75;

  /// aspect ratio 2.00
  T get ratio200 => this..innerRatio = 2.00;
}
