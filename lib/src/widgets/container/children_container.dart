import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'children_container.g.dart';

/// Barry
/// @date 2024/8/26
/// describe:

class StackBuilder extends ChildrenBuilder<Widget>
    with TextDirectionBuilder, ClipBuilder, StackFeature, SizeBuilder, PaddingBuilder {
  StackBuilder._();

  @override
  Widget children(List<Widget> children) {
    Widget child = Stack(
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
    with TextDirectionBuilder, TextBaselineBuilder, LinearFeature, SizeBuilder, PaddingBuilder {
  Widget _buildWrapWidget(Widget child) {
    if (size != null || width != null || height != null) {
      child = SizedBox(width: size ?? width, height: size ?? height, child: child);
    }
    if (hasPadding) {
      child = Padding(padding: finalPadding!, child: child);
    }
    if (_expanded) {
      child = Expanded(child: child);
    }
    return child;
  }
}

class RowBuilder extends _LinearBuilder {
  RowBuilder._();

  @override
  Widget children(List<Widget> children) {
    return _buildWrapWidget(Row(
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
