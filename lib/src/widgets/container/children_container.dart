import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'children_container.g.dart';

/// Barry
/// @date 2024/8/26
/// describe:

class _StackBuilder extends ChildrenBuilder<Widget>
    with TextDirectionBuilder, ClipBuilder, StackFeature, SizeBuilder, PaddingBuilder, KeyBuilder {
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
        KeyBuilder {
  Widget _buildWrapWidget(Widget child) {
    if (size != null || width != null || height != null) {
      child = SizedBox(width: size ?? width, height: size ?? height, child: child);
    }
    if (hasPadding) {
      child = Padding(padding: finalPadding!, child: child);
    }
    return createExpanded(child);
  }
}

class _RowBuilder extends _LinearBuilder {
  _RowBuilder._();

  @override
  Widget children(List<Widget> children) {
    return _buildWrapWidget(Row(
      key: innerKey,
      mainAxisAlignment: _mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: _crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: _mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      textBaseline: textBaseline,
      verticalDirection: _verticalDirection ?? VerticalDirection.down,
      children: children,
    ));
  }
}

class _ColumnBuilder extends _LinearBuilder {
  _ColumnBuilder._();

  @override
  Widget children(List<Widget> children) {
    return _buildWrapWidget(Column(
      key: innerKey,
      mainAxisAlignment: _mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: _crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: _mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      textBaseline: textBaseline,
      verticalDirection: _verticalDirection ?? VerticalDirection.down,
      children: children,
    ));
  }
}
