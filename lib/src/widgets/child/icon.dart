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
  final IconData icon;
  List<Shadow>? shadows;

  _IconBuilder._(this.icon);

  @override
  Widget get mk {
    return createPadding(
      Icon(
        icon,
        size: size ?? height ?? width,
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

extension IconWidgetBuilderExt<T extends _IconBuilder> on T {
  T shadows(List<BoxShadow> shadows) => this..shadows = shadows;

  T size(double size) => this..size = size;
}
