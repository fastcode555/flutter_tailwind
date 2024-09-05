import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

IconBuilder icon(IconData icon) => IconBuilder._(icon);

class IconBuilder extends MkBuilder<Widget>
    with ColorBuilder, TextDirectionBuilder, SizeBuilder, PaddingBuilder, OpacityBuilder {
  final IconData icon;
  List<Shadow>? shadows;

  IconBuilder._(this.icon);

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
  IconBuilder get icon => IconBuilder._(this);
}

extension IconBuilderExt<T extends IconBuilder> on T {
  T shadows(List<BoxShadow> shadows) => this..shadows = shadows;

  T size(double size) => this..size = size;
}
