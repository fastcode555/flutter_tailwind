/// Barry
/// @date 2024/9/13
/// describe:
mixin IconBuilder {
  dynamic innerIcon;
}

extension IconBuilderExt<T extends IconBuilder> on T {
  T icon(dynamic icon) => this..innerIcon = icon;
}
