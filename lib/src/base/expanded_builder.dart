import 'package:flutter/widgets.dart';

/// Barry
/// @date 2024/10/15
/// describe:
mixin ExpandedBuilder {
  int? flex;

  Widget createExpanded(Widget child) {
    if (flex != null) {
      return Expanded(child: child, flex: flex ?? 1);
    }
    return child;
  }
}

extension ExpandedBuilderExt<T extends ExpandedBuilder> on T {
  T get expanded => this..flex = 1;

  T get expanded2 => this..flex = 2;

  T get expanded3 => this..flex = 3;

  T get expanded4 => this..flex = 4;

  T get expanded5 => this..flex = 5;

  T get expanded6 => this..flex = 6;

  T get expanded7 => this..flex = 7;

  T get expanded8 => this..flex = 8;

  T get expanded9 => this..flex = 9;
}
