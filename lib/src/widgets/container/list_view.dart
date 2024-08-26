import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/src/base/padding_builder.dart';

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

mixin ScrollFeature {
  Axis? scrollDirection;
  ScrollController? _controller;
  bool _reverse = false;
  bool _shrinkWrap = false;
  ScrollPhysics? _physics;
  Widget? _separated;
  IndexedWidgetBuilder? _separatorBuilder;
}

extension ScrollFeatureExt<T extends ScrollFeature> on T {
  T get vertical => this..scrollDirection = Axis.vertical;

  T get horizontal => this..scrollDirection = Axis.horizontal;

  T get reverse => this.._reverse = true;

  T get shrinkWrap => this.._shrinkWrap = true;

  T get neverScroll => this.._physics = const NeverScrollableScrollPhysics();

  T scrollController(ScrollController controller) => this.._controller = controller;

  T separated(Widget widget) => this.._separated = widget;

  T separatedBuilder(IndexedWidgetBuilder builder) => this.._separatorBuilder = builder;
}

ListViewBuilder listview(int? itemCount, NullableIndexedWidgetBuilder builder) => ListViewBuilder._(itemCount, builder);

class ListViewBuilder extends MkBuilder<ListView> with ScrollFeature, PaddingBuilder {
  final NullableIndexedWidgetBuilder builder;
  final int? itemCount;

  ListViewBuilder._(this.itemCount, this.builder);

  @override
  ListView get mk {
    if (_separatorBuilder != null || _separated != null) {
      return ListView.separated(
        itemBuilder: builder,
        itemCount: itemCount ?? 0,
        padding: innerPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
        separatorBuilder: _separatorBuilder != null ? _separatorBuilder! : (_, __) => _separated!,
      );
    }
    return ListView.builder(
      itemBuilder: builder,
      itemCount: itemCount ?? 0,
      padding: innerPadding,
      scrollDirection: scrollDirection ?? Axis.vertical,
      controller: _controller,
      reverse: _reverse,
      shrinkWrap: _shrinkWrap,
      physics: _physics,
    );
  }
}

/// Don't use it,it is not a good solution for gridview
@deprecated
GridViewBuilder gridview(int? itemCount, SliverGridDelegate gridDelegate, NullableIndexedWidgetBuilder builder) =>
    GridViewBuilder._(itemCount, gridDelegate, builder);

@deprecated
class GridViewBuilder extends MkBuilder<GridView> with ScrollFeature, PaddingBuilder {
  final NullableIndexedWidgetBuilder builder;
  final int? itemCount;
  final SliverGridDelegate gridDelegate;

  GridViewBuilder._(this.itemCount, this.gridDelegate, this.builder);

  @override
  GridView get mk => GridView.builder(
        gridDelegate: gridDelegate,
        itemBuilder: builder,
        itemCount: itemCount ?? 0,
        padding: innerPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
}
