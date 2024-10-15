import 'package:flutter/widgets.dart';

/// Barry
/// @date 2024/10/15
/// describe:
mixin ExpandedBuilder {
  bool _innerExpanded = false;

  Widget createExpanded(Widget child) {
    if (_innerExpanded) {
      return Expanded(child: child);
    }
    return child;
  }
}

extension ExpandedBuilderExt<T extends ExpandedBuilder> on T {
  T get expanded => this.._innerExpanded = true;
}
