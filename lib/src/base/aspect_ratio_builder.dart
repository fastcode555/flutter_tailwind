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

  /// aspect ratio 0.50
  T get ratio50 => this..innerRatio = 0.50;

  /// aspect ratio 0.75
  T get ratio75 => this..innerRatio = 0.75;

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
