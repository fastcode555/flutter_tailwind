import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/utils/list_ext.dart';

part 'children_container.g.dart';

/// Barry
/// @date 2024/8/26
/// describe:

class _StackBuilder extends ChildrenBuilder<Widget>
    with TextDirectionBuilder, ClipBuilder, StackFeature, SizeBuilder, PaddingBuilder, KeyBuilder, ColorBuilder {
  _StackBuilder._();

  @override
  Widget children(List<Widget> children) {
    Widget child = Stack(
      key: innerKey,
      alignment: _alignment,
      textDirection: textDirection,
      fit: _fit,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      children: children,
    );
    if (size != null || width != null || height != null) {
      child = SizedBox(width: size ?? width, height: size ?? height, child: child);
    }
    if (hasPadding) {
      child = Padding(padding: finalPadding!, child: child);
    }
    if (innerColor != null) {
      child = DecoratedBox(decoration: BoxDecoration(color: innerColor), child: child);
    }

    return child;
  }
}

abstract class _LinearBuilder extends ChildrenBuilder<Widget>
    with
        TextDirectionBuilder,
        TextBaselineBuilder,
        LinearFeature,
        SizeBuilder,
        PaddingBuilder,
        ExpandedBuilder,
        KeyBuilder,
        ColorBuilder,
        SpacingBuilder {
  Widget _buildWrapWidget(Widget child) {
    if (size != null || width != null || height != null) {
      child = SizedBox(width: size ?? width, height: size ?? height, child: child);
    }
    if (hasPadding) {
      child = Padding(padding: finalPadding!, child: child);
    }
    if (innerColor != null) {
      child = DecoratedBox(decoration: BoxDecoration(color: innerColor), child: child);
    }
    return createExpanded(child);
  }
}

class _RowBuilder extends _LinearBuilder {
  _RowBuilder._();

  @override
  Widget children(List<Widget> children) {
    final spacing = innerSpacing ?? innerRunSpacing ?? innerMainAxisSpacing ?? innerCrossAxisSpacing;

    return _buildWrapWidget(Row(
      key: innerKey,
      mainAxisAlignment: _mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: _crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: _mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      textBaseline: textBaseline,
      verticalDirection: _verticalDirection ?? VerticalDirection.down,
      children: spacing != null ? children.joinWidget(SizedBox(width: spacing)) : children,
    ));
  }
}

class _ColumnBuilder extends _LinearBuilder {
  _ColumnBuilder._();

  @override
  Widget children(List<Widget> children) {
    final spacing = innerSpacing ?? innerRunSpacing ?? innerMainAxisSpacing ?? innerCrossAxisSpacing;
    return _buildWrapWidget(Column(
      key: innerKey,
      mainAxisAlignment: _mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: _crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: _mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      textBaseline: textBaseline,
      verticalDirection: _verticalDirection ?? VerticalDirection.down,
      children: spacing != null ? children.joinWidget(SizedBox(height: spacing)) : children,
    ));
  }
}
