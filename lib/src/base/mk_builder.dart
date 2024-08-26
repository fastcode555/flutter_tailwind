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

abstract class ChildrenMkBuilder<T> extends MkBuilder<T> {
  T children(List<Widget> children);
}

abstract class ChildrenBuilder<T> {
  T children(List<Widget> children);
}
