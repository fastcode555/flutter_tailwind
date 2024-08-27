import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/20
/// describe:
abstract class MkBuilder<T> {
  T get mk;
}

abstract class ChildMkBuilder<T> extends MkBuilder<T> {
  T child(Widget child);
}

abstract class ChildBuilder<T> {
  T child(Widget child);
}

abstract class ChildrenBuilder<T> {
  T children(List<Widget> children);
}

abstract class ClickBuilder<T> {
  Widget click({GestureTapCallback? onTap});
}

extension MkBuilderExt<T extends MkBuilder<Widget>> on T {
  Widget click({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      onLongPress: onLongPress,
      child: mk,
    );
  }

  Widget inkwellClick({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return InkWell(onTap: onTap, onLongPress: onLongPress, child: mk);
  }

  Widget iconClick({GestureTapCallback? onTap}) => IconButton(onPressed: onTap, icon: mk);
}

extension ClickListenerExt on Widget {
  Widget click({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      onLongPress: onLongPress,
      child: this,
    );
  }

  Widget inkwellClick({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return InkWell(onTap: onTap, onLongPress: onLongPress, child: this);
  }
}
