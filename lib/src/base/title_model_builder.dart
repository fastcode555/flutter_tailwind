import 'dart:ui';

/// Barry
/// @date 2024/9/17
/// describe:
mixin TitleModelBuilder {
  TileMode? tileMode;
}

extension TitleModelBuilderExt<T extends TitleModelBuilder> on T {
  T get clamp => this..tileMode = TileMode.clamp;

  T get repeated => this..tileMode = TileMode.repeated;

  T get mirror => this..tileMode = TileMode.mirror;

  T get decal => this..tileMode = TileMode.decal;
}
