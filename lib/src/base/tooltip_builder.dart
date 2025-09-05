/// @date 9/5/25
/// describe:
mixin TooltipBuilder {
  String? innerTooltip;
}

extension TooltipBuilderExt<T extends TooltipBuilder> on T {
  T tooltip(String? tooltip) => this..innerTooltip = tooltip;
}
