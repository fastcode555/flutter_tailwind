import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/gradient_builder.dart';

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
    final borderTop = innerBorderT ?? innerBorderWidth ?? 0;
    final borderLeft = innerBorderL ?? innerBorderWidth ?? 0;
    final borderRight = innerBorderR ?? innerBorderWidth ?? 0;
    final borderBottom = innerBorderB ?? innerBorderWidth ?? 0;

    final borderT = BorderSide(color: innerBorderTColor ?? borderColor ?? Colors.white, width: borderTop);
    final borderL = BorderSide(color: innerBorderLColor ?? borderColor ?? Colors.white, width: borderLeft);
    final borderR = BorderSide(color: innerBorderRColor ?? borderColor ?? Colors.white, width: borderRight);
    final borderB = BorderSide(color: innerBorderBColor ?? borderColor ?? Colors.white, width: borderBottom);
    return Border(
      top: _borderTop ?? (borderTop <= 0 ? BorderSide.none : borderT),
      bottom: _borderBottom ?? (borderBottom <= 0 ? BorderSide.none : borderB),
      left: _borderLeft ?? (borderLeft <= 0 ? BorderSide.none : borderL),
      right: _borderRight ?? (borderRight <= 0 ? BorderSide.none : borderR),
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
///![](https://github.com/fastcode555/flutter_tailwind/blob/master/images/container_image.png?raw=true)
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
        ExpandedBuilder,
        KeyBuilder,
        GradientBuilder {
  BorderRadiusGeometry? get _internalBorderRadius {
    if (isCircle) return null;
    if (hasRadius) {
      return borderRadius;
    }
    return null;
  }

  BoxBorder? get _internalBorder => createBorder(borderColor);

  bool get _useContainer =>
      width != null || height != null || size != null || hasPadding || hasMargin || alignment != null || hasConstraint;

  BoxConstraints? get _constraints => hasConstraint
      ? BoxConstraints(
          maxWidth: innerMaxWidth ?? double.infinity,
          maxHeight: innerMaxHeight ?? double.infinity,
          minWidth: innerMinWidth ?? 0.0,
          minHeight: innerMinHeight ?? 0.0,
        )
      : null;

  @override
  Widget get mk {
    if (_useContainer) {
      return createExpanded(
        Container(
          key: innerKey,
          width: width ?? size,
          height: height ?? size,
          padding: finalPadding,
          margin: finalMargin,
          alignment: alignment,
          constraints: _constraints,
          decoration: decoration ??
              BoxDecoration(
                color: innerColor.opacity(innerOpacity),
                shape: shape ?? BoxShape.rectangle,
                border: _internalBorder,
                borderRadius: _internalBorderRadius,
                boxShadow: boxShadow,
                gradient: innerGradient,
              ),
        ),
      );
    }

    return createExpanded(DecoratedBox(
      key: innerKey,
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
        key: innerKey,
        width: width ?? size,
        height: height ?? size,
        padding: finalPadding,
        margin: finalMargin,
        alignment: alignment,
        constraints: _constraints,
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
      key: innerKey,
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
