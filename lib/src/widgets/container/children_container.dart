import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/tailwind.dart';

/// Barry
/// @date 2024/8/26
/// describe:

mixin StackFeature {
  StackFit _fit = StackFit.loose;
  AlignmentGeometry _alignment = AlignmentDirectional.topStart;
}
mixin LinearFeature {
  MainAxisSize? _mainAxisSize;
  MainAxisAlignment? _mainAxisAlignment;
  CrossAxisAlignment? _crossAxisAlignment;
  VerticalDirection? _verticalDirection;
  bool _expanded = false;
}

StackBuilder get stack => StackBuilder._();

RowBuilder get row => RowBuilder._();

ColumnBuilder get column => ColumnBuilder._();

extension LinearFeatureExt<T extends LinearFeature> on T {
  T get min => this.._mainAxisSize = MainAxisSize.min;

  T get max => this.._mainAxisSize = MainAxisSize.max;

  T get start => this.._mainAxisAlignment = MainAxisAlignment.start;

  T get end => this.._mainAxisAlignment = MainAxisAlignment.end;

  T get center => this.._mainAxisAlignment = MainAxisAlignment.center;

  T get spaceBetween => this.._mainAxisAlignment = MainAxisAlignment.spaceBetween;

  T get spaceEvenly => this.._mainAxisAlignment = MainAxisAlignment.spaceEvenly;

  T get spaceAround => this.._mainAxisAlignment = MainAxisAlignment.spaceAround;

  /// Cross 设置的状态
  T get crossStart => this.._crossAxisAlignment = CrossAxisAlignment.start;

  T get crossEnd => this.._crossAxisAlignment = CrossAxisAlignment.end;

  T get crossCenter => this.._crossAxisAlignment = CrossAxisAlignment.center;

  T get crossStretch => this.._crossAxisAlignment = CrossAxisAlignment.stretch;

  T get crossBaseline => this.._crossAxisAlignment = CrossAxisAlignment.baseline;

  /// vertical direction
  T get down => this.._verticalDirection = VerticalDirection.down;

  T get up => this.._verticalDirection = VerticalDirection.up;

  T get expanded => this.._expanded = true;
}

extension StackFeatureExt<T extends StackFeature> on T {
  T get loose => this.._fit = StackFit.loose;

  T get expand => this.._fit = StackFit.expand;

  T get passthrough => this.._fit = StackFit.passthrough;

  T get topStart => this.._alignment = AlignmentDirectional.topStart;

  T get topCenter => this.._alignment = AlignmentDirectional.topCenter;

  T get topEnd => this.._alignment = AlignmentDirectional.topEnd;

  T get centerStart => this.._alignment = AlignmentDirectional.centerStart;

  T get center => this.._alignment = AlignmentDirectional.center;

  T get centerEnd => this.._alignment = AlignmentDirectional.centerEnd;

  T get bottomStart => this.._alignment = AlignmentDirectional.bottomStart;

  T get bottomCenter => this.._alignment = AlignmentDirectional.bottomCenter;

  T get bottomEnd => this.._alignment = AlignmentDirectional.bottomEnd;
}

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

class ColumnBuilder extends _LinearBuilder {
  ColumnBuilder._();

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
