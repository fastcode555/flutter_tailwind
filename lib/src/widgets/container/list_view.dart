import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

part 'list_view.g.dart';

/// Barry
/// @date 2024/8/24
/// describe:

ListViewBuilder get listview => ListViewBuilder._();

class ListViewBuilder extends ItemBuilder with ScrollFeature, PaddingBuilder, SizeBuilder, SeparatorBuilder {
  ListViewBuilder._();

  bool get _isHorizontal => scrollDirection == Axis.horizontal;

  ///判断
  bool get _hasSeparated =>
      _separatorBuilder != null || _separated != null || _separatedValue != null || _isDivider != null;

  Widget get _localSeparated {
    if (_separated != null) return _separated!;
    if (_isDivider ?? false) {
      if (_isHorizontal) {
        return const VerticalDivider();
      }
      return const Divider();
    }

    if (_isHorizontal) {
      return SizedBox(width: _separatedValue);
    }
    return SizedBox(height: _separatedValue);
  }

  @override
  Widget builder(int? itemCount, NullableIndexedWidgetBuilder builder) {
    Widget? listview;
    if (_hasSeparated) {
      listview = ListView.separated(
        itemBuilder: builder,
        itemCount: itemCount ?? 0,
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
        itemBuilder: builder,
        itemCount: itemCount ?? 0,
        padding: finalPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
    }
    if (size != null || width != null || height != null) {
      return SizedBox(
        width: size ?? width,
        height: size ?? height,
        child: listview,
      );
    }
    return listview;
  }

  @override
  Widget dataBuilder<T>(List<T>? data, ItemListFunction<T> builder) {
    return this.builder(data?.length, (context, index) => builder(context, index, data![index]));
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
        padding: finalPadding,
        scrollDirection: scrollDirection ?? Axis.vertical,
        controller: _controller,
        reverse: _reverse,
        shrinkWrap: _shrinkWrap,
        physics: _physics,
      );
}
