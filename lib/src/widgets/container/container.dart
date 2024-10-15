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

_BoxDecorationBuilder get bd => _BoxDecorationBuilder();

class _BoxDecorationBuilder
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
  Gradient? _gradient;

  BorderRadiusGeometry? get _internalBorderRadius {
    if (shape == BoxShape.circle) return null;
    if (hasRadius) {
      return borderRadius;
    }
    return null;
  }

  BoxBorder? get _internalBorder {
    if (_border != null) return _border;
    if (borderColor != null) {
      return Border.all(color: borderColor!, width: innerBorderWidth ?? 1.0);
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
        backgroundBlendMode: innerBlendMode,
        shape: shape ?? BoxShape.rectangle,
        boxShadow: boxShadow,
      );
}

extension BoxDecorationBuilderColorExt on Color {
  _BoxDecorationBuilder get bd => _BoxDecorationBuilder()..innerColor = this;
}

extension BoxDecorationBuilderExt on _BoxDecorationBuilder {
  _BoxDecorationBuilder gradient(Gradient gradient) => this.._gradient = gradient;

  _BoxDecorationBuilder bg(Color? color) => this..innerColor = color;

  _BoxDecorationBuilder border(Color color, [double width = 1.0]) => this
    .._border = Border.all(
      color: color,
      width: width,
    );

  _BoxDecorationBuilder borderColor(Color color) => this..borderColor = color;

  _BoxDecorationBuilder bl({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) =>
      this
        .._borderLeft = BorderSide(
          color: color ?? this.borderColor ?? Colors.white,
          width: width,
          style: style,
        );

  _BoxDecorationBuilder br({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) =>
      this
        .._borderRight = BorderSide(
          color: color ?? this.borderColor ?? Colors.white,
          width: width,
          style: style,
        );

  _BoxDecorationBuilder bt({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) =>
      this
        .._borderTop = BorderSide(
          color: color ?? this.borderColor ?? Colors.white,
          width: width,
          style: style,
        );

  _BoxDecorationBuilder bb({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) =>
      this
        .._borderBottom = BorderSide(
          color: color ?? this.borderColor ?? Colors.white,
          width: width,
          style: style,
        );
}

///## Don't have child,use mk to create empty container
///container.s100.greenAccent.borderBrown.rounded8.border5.mk
///
///## Have child
///container.s100.greenAccent.borderBrown.rounded8.border5.child(
/// child,
///)
ContainerBuilder get container => ContainerBuilder();

class ContainerBuilder extends ChildMkBuilder<Widget>
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
        OpacityBuilder,
        ExpandedBuilder {
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
      return Border.all(color: borderColor.opacity(innerOpacity)!, width: innerBorderWidth ?? 1.0);
    }
    return Border(
      top: _borderTop ?? BorderSide.none,
      bottom: _borderBottom ?? BorderSide.none,
      left: _borderLeft ?? BorderSide.none,
      right: _borderRight ?? BorderSide.none,
    );
  }

  bool get _useContainer =>
      width != null || height != null || size != null || hasPadding || hasMargin || alignment != null;

  @override
  Widget get mk {
    if (_useContainer) {
      return createExpanded(
        Container(
          width: width ?? size,
          height: height ?? size,
          padding: finalPadding,
          margin: finalMargin,
          alignment: alignment,
          decoration: decoration ??
              BoxDecoration(
                color: innerColor.opacity(innerOpacity),
                shape: shape ?? BoxShape.rectangle,
                border: _internalBorder,
                borderRadius: _internalBorderRadius,
                boxShadow: boxShadow,
              ),
        ),
      );
    }

    return createExpanded(DecoratedBox(
      decoration: decoration ??
          BoxDecoration(
            color: innerColor.opacity(innerOpacity),
            shape: shape ?? BoxShape.rectangle,
            border: _internalBorder,
            borderRadius: _internalBorderRadius,
            boxShadow: boxShadow,
          ),
    ));
  }

  @override
  Widget child(Widget child) {
    if (_useContainer) {
      return createExpanded(Container(
        width: width ?? size,
        height: height ?? size,
        padding: finalPadding,
        margin: finalMargin,
        alignment: alignment,
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
      ));
    }

    return createExpanded(DecoratedBox(
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
    ));
  }
}
