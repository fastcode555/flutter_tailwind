import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/22
/// describe:
mixin CompleteDecoration {
  BoxDecoration? decoration;
}

mixin ImageProviderBuilderMixin {
  String? _image;

  DecorationImage? get _decorImage {
    if (_image == null || _image!.isEmpty) return null;
    return DecorationImage(image: ImageLoader.getImageProvider(_image) ?? AssetImage(_image!));
  }
}

extension ImageProviderBuilderExt<T extends ImageProviderBuilderMixin> on T {
  T image(String? image) => this.._image = image;
}

BoxDecorationBuilder get bd => BoxDecorationBuilder();

class BoxDecorationBuilder
    with
        ColorBuilder,
        BorderWidthBuilder,
        BorderRadiusBuilder,
        BorderColorBuilder,
        BlendModeBuilder,
        BoxShapeBuilder,
        ShadowBuilder,
        CompleteDecoration,
        ImageProviderBuilderMixin,
        OpacityBuilder {
  BoxBorder? _border;
  BorderSide? _borderLeft;
  BorderSide? _borderRight;
  BorderSide? _borderTop;
  BorderSide? _borderBottom;
  BorderRadiusGeometry? _borderRadius;
  Gradient? _gradient;

  BorderRadiusGeometry? get _internalBorderRadius {
    if (shape == BoxShape.circle) return null;
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

  ///mk = make = create
  BoxDecoration get mk =>
      decoration ??
      BoxDecoration(
        color: innerColor.opacity(innerOpacity),
        image: _decorImage,
        border: _internalBorder,
        borderRadius: _internalBorderRadius,
        gradient: _gradient,
        backgroundBlendMode: blendMode,
        shape: shape ?? BoxShape.rectangle,
        boxShadow: boxShadow,
      );
}

extension BoxDecorationBuilderColorExt on Color {
  BoxDecorationBuilder get bd => BoxDecorationBuilder()..innerColor = this;
}

extension BoxDecorationBuilderExt on BoxDecorationBuilder {
  BoxDecorationBuilder gradient(Gradient gradient) => this.._gradient = gradient;

  BoxDecorationBuilder bg(Color? color) => this..innerColor = color;

  // BoxDecorationBuilder borderRadius(BorderRadiusGeometry? borderRadius) => this.._borderRadius = borderRadius;
  BoxDecorationBuilder rOnly([double? topLeft, double? topRight, double? bottomLeft, double? bottomRight]) => this
    .._borderRadius = BorderRadius.only(
      topLeft: Radius.circular(topLeft ?? 0),
      topRight: Radius.circular(topRight ?? 0),
      bottomLeft: Radius.circular(bottomLeft ?? 0),
      bottomRight: Radius.circular(bottomRight ?? 0),
    );

  BoxDecorationBuilder rh([double? left, double? right]) => this
    .._borderRadius = BorderRadius.horizontal(
      left: Radius.circular(left ?? 0),
      right: Radius.circular(right ?? 0),
    );

  BoxDecorationBuilder rv([double? top, double? bottom]) => this
    .._borderRadius = BorderRadius.vertical(
      top: Radius.circular(top ?? 0),
      bottom: Radius.circular(bottom ?? 0),
    );

  BoxDecorationBuilder border(Color color, [double width = 1.0]) =>
      this.._border = Border.all(color: color, width: width);

  BoxDecorationBuilder borderColor(Color color) => this..borderColor = color;

  BoxDecorationBuilder bl({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderLeft = BorderSide(color: color ?? this.borderColor ?? Colors.white, width: width, style: style);

  BoxDecorationBuilder br({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderRight = BorderSide(color: color ?? this.borderColor ?? Colors.white, width: width, style: style);

  BoxDecorationBuilder bt({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderTop = BorderSide(color: color ?? this.borderColor ?? Colors.white, width: width, style: style);

  BoxDecorationBuilder bb({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderBottom = BorderSide(color: color ?? this.borderColor ?? Colors.white, width: width, style: style);
}

ContainerBuilder get container => ContainerBuilder();

class ContainerBuilder extends ChildMkBuilder<Container>
    with
        ColorBuilder,
        SizeBuilder,
        BorderWidthBuilder,
        BorderRadiusBuilder,
        BorderColorBuilder,
        BlendModeBuilder,
        BoxShapeBuilder,
        AlignmentBuilder,
        ShadowBuilder,
        CompleteDecoration,
        PaddingBuilder,
        MarginBuilder,
        ImageProviderBuilderMixin,
        OpacityBuilder {
  BoxBorder? _border;
  BorderSide? _borderLeft;
  BorderSide? _borderRight;
  BorderSide? _borderTop;
  BorderSide? _borderBottom;

  BorderRadiusGeometry? get _internalBorderRadius {
    if (isCircle) return null;
    if (hasRadius) {
      return borderRadius;
    }
    return null;
  }

  BoxBorder? get _internalBorder {
    if (_border != null) return _border;
    if (borderColor != null) {
      return Border.all(color: borderColor.opacity(innerOpacity)!, width: borderWidth ?? 1.0);
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
        padding: finalPadding,
        alignment: alignment ?? Alignment.center,
        decoration: decoration ??
            BoxDecoration(
              color: innerColor.opacity(innerOpacity),
              shape: shape ?? BoxShape.rectangle,
              border: _internalBorder,
              borderRadius: _internalBorderRadius,
              boxShadow: boxShadow,
            ),
      );

  @override
  Container child(Widget child) {
    return Container(
      width: width ?? size,
      height: height ?? size,
      padding: finalPadding,
      margin: finalMargin,
      alignment: alignment ?? Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            color: innerColor.opacity(innerOpacity),
            shape: shape ?? BoxShape.rectangle,
            border: _internalBorder,
            borderRadius: _internalBorderRadius,
            boxShadow: boxShadow,
            image: _decorImage,
          ),
      child: child,
    );
  }
}
