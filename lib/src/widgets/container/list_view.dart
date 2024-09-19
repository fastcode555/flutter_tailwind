import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'list_view.g.dart';

/// Barry
/// @date 2024/8/24
/// describe:
///[ListView.separated]
_ListViewBuilder get listview => _ListViewBuilder._();

class _ListViewBuilder extends ItemBuilder
    with ScrollFeature, PaddingBuilder, SizeBuilder, SeparatorBuilder, StepMixin {
  bool get _isHorizontal => scrollDirection == Axis.horizontal;

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
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
        separatorBuilder: _separatorBuilder != null ? _separatorBuilder! : (_, __) => _localSeparated,
      );
    } else {
      listview = ListView.builder(
        itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
        itemCount: _itemCount(itemCount, stepBuilder),
        padding: finalPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
    }
    if (_hasSize) {
      return SizedBox(width: size ?? width, height: size ?? height, child: listview);
    }

    if (_expanded) {
      return Expanded(child: listview);
    }

    return listview;
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
_GridViewBuilder get gridview => _GridViewBuilder._();

class _GridViewBuilder extends ItemBuilder
    with ScrollFeature, PaddingBuilder, GridViewFeature, AspectRatioBuilder, StepMixin {
  _GridViewBuilder._();

  @override
  Widget builder(
    int? itemCount,
    NullableIndexedWidgetBuilder builder, {
    NullableIndexedWidgetBuilder? stepBuilder,
  }) {
    if (_childWidth != null) {
      return LayoutBuilder(builder: (context, constraints) {
        var count = constraints.maxWidth ~/ (_childWidth! + (_crossAxisSpacing ?? _spacing ?? 0.0));
        count = count < 2 ? 2 : count;
        if (_staggered) {
          return _buildStaggeredGridView(itemCount, builder, stepBuilder, count);
        }
        return _buildGridView(itemCount, builder, stepBuilder, count);
      });
    }
    var gridView;
    if (_staggered) {
      gridView = _buildStaggeredGridView(itemCount, builder, stepBuilder, _crossAxisCount);
    } else {
      gridView = _buildGridView(itemCount, builder, stepBuilder, _crossAxisCount);
    }

    if (_expanded) {
      return Expanded(child: gridView);
    }
    return gridView;
  }

  Widget _buildGridView(
    int? itemCount,
    NullableIndexedWidgetBuilder builder,
    NullableIndexedWidgetBuilder? stepBuilder,
    int? crossAxisCount,
  ) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? 2,
        mainAxisSpacing: _mainAxisSpacing ?? _spacing ?? 0.0,
        crossAxisSpacing: _crossAxisSpacing ?? _spacing ?? 0.0,
        childAspectRatio: innerRatio ?? 1.0,
      ),
      itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder),
      itemCount: _itemCount(itemCount, stepBuilder),
      padding: finalPadding,
      scrollDirection: scrollDirection ?? Axis.vertical,
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
    return MasonryGridView.count(
      crossAxisCount: crossAxisCount ?? 2,
      mainAxisSpacing: _mainAxisSpacing ?? _spacing ?? 0.0,
      crossAxisSpacing: _crossAxisSpacing ?? _spacing ?? 0.0,
      itemBuilder: (context, index) => _itemBuilder(context, index, builder, stepBuilder) ?? gapEmpty,
      itemCount: _itemCount(itemCount, stepBuilder),
      padding: finalPadding,
      scrollDirection: scrollDirection ?? Axis.vertical,
      controller: _controller,
      reverse: _reverse,
      shrinkWrap: _shrinkWrap,
      physics: _physics,
    );
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
