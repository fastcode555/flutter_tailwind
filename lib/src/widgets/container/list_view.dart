import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'list_view.g.dart';

/// Barry
/// @date 2024/8/24
/// describe:
///[ListView.separated]
_ListViewBuilder get listview => _ListViewBuilder._();

class _ListViewBuilder extends ItemBuilder
    with
        ScrollFeature,
        PaddingBuilder,
        SizeBuilder,
        SeparatorBuilder,
        StepMixin,
        AxisBuilder,
        ExpandedBuilder,
        KeyBuilder {
  bool get _isHorizontal => direction == Axis.horizontal;

  ///判断
  bool get _hasSeparated =>
      _separatorBuilder != null || _separated != null || _separatedValue != null || _isDivider != null;

  bool get _hasSize => size != null || width != null || height != null;

  Widget get _localSeparated {
    if (_separated != null) return _separated!;

    if (_isDivider ?? false) {
      if (_isHorizontal) return const VerticalDivider();

      return const Divider();
    }

    if (_isHorizontal) return SizedBox(width: _separatedValue);

    return SizedBox(height: _separatedValue);
  }

  _ListViewBuilder._();

  @override
  Widget builder(
    int? itemCount,
    NullableIndexedWidgetBuilder builder, {
    NullableIndexedWidgetBuilder? stepBuilder,
  }) {
    Widget? listview;
    if (_hasSeparated) {
      listview = ListView.separated(
        key: innerKey,
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: direction ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
        separatorBuilder: _separatorBuilder != null ? _separatorBuilder! : (_, __) => _localSeparated,
      );
    } else {
      listview = ListView.builder(
        key: innerKey,
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: direction ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
    }
    if (_hasSize) {
      return SizedBox(width: size ?? width, height: size ?? height, child: listview);
    }

    return createExpanded(listview);
  }

  @override
  Widget dataBuilder<T>(
    List<T>? data,
    ItemListFunction<T> builder, {
    NullableIndexedWidgetBuilder? stepBuilder,
  }) {
    return this.builder(
      data?.length,
      (context, index) => builder(context, index, data![index]),
      stepBuilder: stepBuilder,
    );
  }
}

/// [GridView.builder]
///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/image_5.png?raw=true)
_GridViewBuilder get gridview => _GridViewBuilder._();

class _GridViewBuilder extends ItemBuilder
    with
        ScrollFeature,
        PaddingBuilder,
        GridViewFeature,
        AspectRatioBuilder,
        StepMixin,
        AxisBuilder,
        SpacingBuilder,
        ExpandedBuilder,
        KeyBuilder {
  _GridViewBuilder._();

  @override
  Widget builder(
    int? itemCount,
    NullableIndexedWidgetBuilder builder, {
    NullableIndexedWidgetBuilder? stepBuilder,
  }) {
    Widget gridView;
    if (_staggered) {
      gridView = _buildStaggeredGridView(itemCount, builder, stepBuilder, _crossAxisCount);
    } else {
      gridView = _buildGridView(itemCount, builder, stepBuilder, _crossAxisCount);
    }

    return createExpanded(gridView);
  }

  Widget _buildGridView(
    int? itemCount,
    NullableIndexedWidgetBuilder builder,
    NullableIndexedWidgetBuilder? stepBuilder,
    int? crossAxisCount,
  ) {
    late SliverGridDelegate gridDelegate;

    if (_childWidth != null) {
      gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: _childWidth!,
        mainAxisSpacing: innerMainAxisSpacing ?? innerSpacing ?? 0.0,
        crossAxisSpacing: innerCrossAxisSpacing ?? innerSpacing ?? 0.0,
        childAspectRatio: innerRatio ?? 1.0,
      );
    } else {
      gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? 2,
        mainAxisSpacing: innerMainAxisSpacing ?? innerSpacing ?? 0.0,
        crossAxisSpacing: innerCrossAxisSpacing ?? innerSpacing ?? 0.0,
        childAspectRatio: innerRatio ?? 1.0,
      );
    }

    return GridView.builder(
      key: innerKey,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
      itemCount: _itemCount(itemCount, stepBuilder),
      padding: finalPadding,
      scrollDirection: direction ?? Axis.vertical,
      controller: _controller,
      reverse: _reverse,
      shrinkWrap: _shrinkWrap,
      physics: _physics,
    );
  }

  Widget _buildStaggeredGridView(
    int? itemCount,
    NullableIndexedWidgetBuilder builder,
    NullableIndexedWidgetBuilder? stepBuilder,
    int? crossAxisCount,
  ) {
    if (_childWidth != null) {
      return MasonryGridView.extent(
        key: innerKey,
        maxCrossAxisExtent: _childWidth!,
        mainAxisSpacing: innerMainAxisSpacing ?? innerSpacing ?? 0.0,
        crossAxisSpacing: innerCrossAxisSpacing ?? innerSpacing ?? 0.0,
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder) ?? gapEmpty,
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: direction ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
    } else {
      return MasonryGridView.count(
        key: innerKey,
        crossAxisCount: crossAxisCount ?? 2,
        mainAxisSpacing: innerMainAxisSpacing ?? innerSpacing ?? 0.0,
        crossAxisSpacing: innerCrossAxisSpacing ?? innerSpacing ?? 0.0,
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder) ?? gapEmpty,
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: direction ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
    }
  }

  @override
  Widget dataBuilder<T>(
    List<T>? data,
    ItemListFunction<T> builder, {
    NullableIndexedWidgetBuilder? stepBuilder,
  }) {
    return this.builder(
      data?.length,
      (context, index) => builder(context, index, data![index]),
      stepBuilder: stepBuilder,
    );
  }
}
