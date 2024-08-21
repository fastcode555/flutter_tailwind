import 'dart:ui';

/// Barry
/// @date 2024/8/20
/// describe:
mixin ClipBuilder {
  Clip? clipBehavior;
}

extension ClipBuilderExt<T extends ClipBuilder> on T {
  T get hardEdge => this..clipBehavior = Clip.hardEdge;

  T get antiAlias => this..clipBehavior = Clip.antiAlias;

  T get antiAliasWithSaveLayer => this..clipBehavior = Clip.antiAliasWithSaveLayer;
}
