import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/positioned_builder.dart';

/// Barry
/// @date 2024/12/2
/// describe:

_PositionedBuilder get positioned => _PositionedBuilder();

class _PositionedBuilder extends ChildBuilder<Positioned> with PositionedBuilder {
  @override
  Positioned child(Widget child) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: child,
    );
  }
}
