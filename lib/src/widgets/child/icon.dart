import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

///# eg:
///- Icons.connected_tv_sharp.icon.redAccent.s100.mk
///- icon(Icons.connected_tv_sharp).redAccent.s100.mk
_IconBuilder icon(IconData icon) => _IconBuilder._(icon);

class _IconBuilder extends MkBuilder<Widget>
    with ColorBuilder, TextDirectionBuilder, SizeBuilder, PaddingBuilder, OpacityBuilder {
  // 可空：Flutter 的 Icon(IconData?) 本就接受 null，允许对可空 IconData? 字段直接 .icon
  final IconData? icon;
  List<Shadow>? shadows;

  _IconBuilder._(this.icon);

  @override
  Widget get mk {
    return createPadding(
      Icon(
        icon,
        size: size != null ? sr(size!) : (height != null ? sh(height!) : (width != null ? sw(width!) : null)),
        color: innerColor.opacity(innerOpacity),
        shadows: shadows,
        textDirection: textDirection,
        applyTextScaling: false,
      ),
    );
  }
}

extension IconStringBuilder on IconData {
  ///# eg:
  ///- Icons.connected_tv_sharp.icon.redAccent.s100.mk
  ///- icon(Icons.connected_tv_sharp).redAccent.s100.mk
  _IconBuilder get icon => _IconBuilder._(this);
}

/// 可空 IconData? 的 .icon（非空 IconData 会优先命中上面更具体的扩展，无歧义）。
/// 用于 `IconData? field` 在 `if (field != null)` 下无法类型提升时仍可 `field.icon`。
extension IconNullableStringBuilder on IconData? {
  _IconBuilder get icon => _IconBuilder._(this);
}

extension IconWidgetBuilderExt<T extends _IconBuilder> on T {
  T shadows(List<BoxShadow> shadows) => this..shadows = shadows;

  T size(double size) => this..size = size;
}
