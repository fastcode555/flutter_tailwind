import 'dart:ui';

/// Barry
/// @date 2024/8/20
/// describe:
mixin ClipBuilder {
  Clip? clipBehavior;
}

extension ClipBuilderExt<T extends ClipBuilder> on T {
  ///[Clip.hardEdge]
  T get hardEdge => this..clipBehavior = Clip.hardEdge;

  ///[Clip.antiAlias]
  T get antiAlias => this..clipBehavior = Clip.antiAlias;

  ///[Clip.antiAliasWithSaveLayer]
  T get antiAliasWithSaveLayer => this..clipBehavior = Clip.antiAliasWithSaveLayer;
}
