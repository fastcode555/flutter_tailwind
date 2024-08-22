import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/tailwind.dart';

/// Barry
/// @date 2024/8/22
/// describe:

ContainerBuilder get container => ContainerBuilder();

class ContainerBuilder extends MkBuilder<Container>
    with
        ColorBuilder,
        SizeBuilder,
        BorderWidthBuilder,
        BorderRadiusBuilder,
        BorderColorBuilder,
        BlendModeBuilder,
        BoxShapeBuilder {
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
        decoration: BoxDecoration(
          color: color,
          shape: shape ?? BoxShape.rectangle,
          border: _internalBorder,
          borderRadius: _internalBorderRadius,
        ),
      );
}
