import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

/// Barry
/// @date 2024/8/26
/// describe:
mixin SeparatedBuilder {
  Widget? separatedWidget;
}

extension SeparatedBuilderExt<T extends SeparatedBuilder> on T {
  T get separated16 => this..separatedWidget = h16;

  T get separated24 => this..separatedWidget = h24;
}
