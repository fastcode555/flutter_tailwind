/// Barry
/// @date 2024/9/13
/// describe:
mixin IconBuilder {
  dynamic innerIcon;
}

extension IconBuilderExt<T extends IconBuilder> on T {
  ///accept the asset image,svg,image link
  T icon(dynamic icon) => this..innerIcon = icon;
}
