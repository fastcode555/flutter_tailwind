import 'package:flutter/widgets.dart';

/// Barry
/// @date 2024/10/15
/// describe:
mixin ExpandedBuilder {
  int? innerFlex;

  Widget createExpanded(Widget child) {
    if (innerFlex != null) {
      return Expanded(child: child, flex: innerFlex ?? 1);
    }
    return child;
  }
}

extension ExpandedBuilderExt<T extends ExpandedBuilder> on T {
  T flex(int flex) => this..innerFlex = flex;

  T get expanded => this..innerFlex = 1;

  T get expanded2 => this..innerFlex = 2;

  T get expanded3 => this..innerFlex = 3;

  T get expanded4 => this..innerFlex = 4;

  T get expanded5 => this..innerFlex = 5;

  T get expanded6 => this..innerFlex = 6;

  T get expanded7 => this..innerFlex = 7;

  T get expanded8 => this..innerFlex = 8;

  T get expanded9 => this..innerFlex = 9;
}
