import 'dart:ui';

/// Barry
/// @date 2024/9/17
/// describe:
mixin TitleModelBuilder {
  TileMode? tileMode;
}

extension TitleModelBuilderExt<T extends TitleModelBuilder> on T {
  ///[TileMode.clamp]
  T get clamp => this..tileMode = TileMode.clamp;

  ///[TileMode.repeated]
  T get repeated => this..tileMode = TileMode.repeated;

  ///[TileMode.mirror]
  T get mirror => this..tileMode = TileMode.mirror;

  ///[TileMode.decal]
  T get decal => this..tileMode = TileMode.decal;
}
