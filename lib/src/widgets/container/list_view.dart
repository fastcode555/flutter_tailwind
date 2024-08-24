import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';

/// Barry
/// @date 2024/8/24
/// describe:
typedef ItemListFunction<T> = Widget Function(BuildContext context, int index, T item);

mixin ChildrenBuilder {
  List<Widget>? _children;
}

extension ChildrenBuilderExt<T extends ChildrenBuilder> on T {
  T children(List<Widget> children) => this.._children = children;
}

mixin ItemListBuilder<T> {
  ItemListFunction<T>? _itemBuilder;
}

extension ItemListBuilderExt<T, P extends ItemListBuilder<T>> on P {
  P builder(ItemListFunction<T> builder) => this.._itemBuilder = builder;
}

mixin ScrollFeature {
  Axis? scrollDirection;
  ScrollController? _controller;
  bool _reverse = false;
  bool _shrinkWrap = false;
  ScrollPhysics? _physics;
}

extension ScrollFeatureExt<T extends ScrollFeature> on T {
  T get vertical => this..scrollDirection = Axis.vertical;

  T get horizontal => this..scrollDirection = Axis.horizontal;

  T get reverse => this.._reverse = true;

  T get shrinkWrap => this.._shrinkWrap = true;

  T get neverScroll => this.._physics = const NeverScrollableScrollPhysics();

  T scrollController(ScrollController controller) => this.._controller = controller;
}

ListViewBuilder<T> listview<T>(List<T> list) => ListViewBuilder<T>(list);

class ListViewBuilder<T> extends MkBuilder<ListView> with ItemListBuilder<T>, ScrollFeature {
  List<T>? list;

  ListViewBuilder(this.list);

  @override
  ListView get mk => ListView.builder(
        itemBuilder: (context, index) => _itemBuilder?.call(context, index, list![index]),
        itemCount: list?.length ?? 0,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
}
