import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/color_builder.dart';
import 'package:flutter_tailwind/src/base/size_builder.dart';
import 'package:flutter_tailwind/src/base/text_feature.dart';

import '../base/mk_builder.dart';

/// Barry
/// @date 2024/8/19
/// describe:

IconBuilder icon(IconData icon) => IconBuilder(icon);

class IconBuilder extends MkBuilder<Icon> with ColorBuilder, TextDirectionBuilder, SizeBuilder {
  final IconData icon;
  List<Shadow>? shadows;

  IconBuilder(this.icon);

  @override
  Icon get mk => Icon(
        icon,
        size: size ?? height ?? width,
        color: color,
        shadows: shadows,
        textDirection: textDirection,
        applyTextScaling: false,
      );
}

extension IconBuilderExt<T extends IconBuilder> on T {
  T shadows(List<BoxShadow> shadows) => this..shadows = shadows;

  T size(double size) => this..size = size;
}
