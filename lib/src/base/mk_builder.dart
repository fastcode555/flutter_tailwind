import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

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

abstract class ChildrenSpanBuilder<T> {
  T children(List<InlineSpan>? children);
}

abstract class ClickBuilder<T> {
  Widget click({GestureTapCallback? onTap});
}

abstract class CallBackBuilder<T> {
  Widget onChanged(T initialValue, Function(T value) onChanged);
}

abstract class RadioCallBackBuilder {
  Widget onChanged<T>(T initialValue, T groupValue, ValueChanged<T> onChanged);
}

abstract class ItemBuilder {
  Widget builder(int? itemCount, NullableIndexedWidgetBuilder builder, {NullableIndexedWidgetBuilder? stepBuilder});

  Widget dataBuilder<T>(List<T>? data, ItemListFunction<T> builder, {NullableIndexedWidgetBuilder? stepBuilder});
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

  Widget iconClick({GestureTapCallback? onTap}) => IconButton(onPressed: onTap, icon: mk);

  Widget inkWellClick({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return InkWell(onTap: onTap, onLongPress: onLongPress, child: mk);
  }
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

  Widget inkWellClick({GestureTapCallback? onTap, GestureLongPressCallback? onLongPress}) {
    return InkWell(onTap: onTap, onLongPress: onLongPress, child: this);
  }

  Widget iconClick({GestureTapCallback? onTap}) => IconButton(onPressed: onTap, icon: this);
}
