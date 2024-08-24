import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/tailwind.dart';

/// Barry
/// @date 2024/8/22
/// describe:
mixin ChildBuilder {
  Widget? _child;
}



extension ChildBilderExt<T extends ChildBuilder> on T {
  T child(Widget child) => this.._child = child;
}



ContainerBuilder get container => ContainerBuilder();

class ContainerBuilder extends MkBuilder<Container>
    with
        ColorBuilder,
        SizeBuilder,
        BorderWidthBuilder,
        BorderRadiusBuilder,
        BorderColorBuilder,
        BlendModeBuilder,
        BoxShapeBuilder,
        AlignmentBuilder,
        ChildBuilder {
  BoxBorder? _border;
  BorderSide? _borderLeft;
  BorderSide? _borderRight;
  BorderSide? _borderTop;
  BorderSide? _borderBottom;
  BorderRadiusGeometry? _borderRadius;

  BorderRadiusGeometry? get _internalBorderRadius {
    if (isCircle) return null;
    return _borderRadius ?? (radius != null ? BorderRadius.circular(radius!) : null);
  }

  BoxBorder? get _internalBorder {
    if (_border != null) return _border;
    if (borderColor != null) {
      return Border.all(color: borderColor!, width: borderWidth ?? 1.0);
    }
    return Border(
      top: _borderTop ?? BorderSide.none,
      bottom: _borderBottom ?? BorderSide.none,
      left: _borderLeft ?? BorderSide.none,
      right: _borderRight ?? BorderSide.none,
    );
  }

  @override
  Container get mk => Container(
        width: width ?? size,
        height: height ?? size,
        alignment: alignment ?? Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          border: _internalBorder,
          borderRadius: _internalBorderRadius,
        ),
        child: _child,
      );
}
