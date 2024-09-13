import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

_IconBuilder icon(IconData icon) => _IconBuilder._(icon);

class _IconBuilder extends MkBuilder<Widget>
    with ColorBuilder, TextDirectionBuilder, SizeBuilder, PaddingBuilder, OpacityBuilder {
  final IconData icon;
  List<Shadow>? shadows;

  _IconBuilder._(this.icon);

  @override
  Widget get mk {
    Widget child = Icon(
      icon,
      size: size ?? height ?? width,
      color: innerColor.opacity(innerOpacity),
      shadows: shadows,
      textDirection: textDirection,
      applyTextScaling: false,
    );
    if (hasPadding) {
      return Padding(padding: finalPadding!, child: child);
    }
    return child;
  }
}

extension IconStringBuilder on IconData {
  _IconBuilder get icon => _IconBuilder._(this);
}

extension IconWidgetBuilderExt<T extends _IconBuilder> on T {
  T shadows(List<BoxShadow> shadows) => this..shadows = shadows;

  T size(double size) => this..size = size;
}
