/// Barry
/// @date 2024/8/28
/// describe:
mixin AspectRatioBuilder {
  double? ratio;
}

extension AspectRatioBuilderExt<T extends AspectRatioBuilder> on T {
  T ratio(double ratio) => this..ratio = ratio;

  T get ratio25 => this..ratio = 0.25;

  T get ratio50 => this..ratio = 0.50;

  T get ratio75 => this..ratio = 0.75;

  T get ratio100 => this..ratio = 1.0;

  T get ratio125 => this..ratio = 1.25;

  T get ratio150 => this..ratio = 1.50;

  T get ratio175 => this..ratio = 1.75;

  T get ratio200 => this..ratio = 2.00;
}
