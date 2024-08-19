import 'dart:io';

import 'package:flutter/material.dart';

import 'base/blend_mode_builder.dart';
import 'base/border_radius_builder.dart';
import 'base/color_builder.dart';

/// Barry
/// @date 4/11/23
/// describe: A bit like Csstailwind or chain programming like ios swift
/// 有点像Csstailwind或者像ios swift的链式编程

BoxDecorationBuilder get bd => BoxDecorationBuilder();

class BoxDecorationBuilder with ColorBuilder, BorderRadiusBuilder, BlendModeBuilder {
  DecorationImage? _image;
  BoxBorder? _border;
  BorderSide? _borderLeft;
  BorderSide? _borderRight;
  BorderSide? _borderTop;
  BorderSide? _borderBottom;
  Color _borderColor = const Color(0xFF000000);
  BorderRadiusGeometry? _borderRadius;
  List<BoxShadow>? _boxShadow;
  Gradient? _gradient;
  BoxShape? _shape;

  ///mk = make = create
  BoxDecoration get mk => BoxDecoration(
        color: color,
        image: _image,
        border: _border ??
            Border(
              top: _borderTop ?? BorderSide.none,
              bottom: _borderBottom ?? BorderSide.none,
              left: _borderLeft ?? BorderSide.none,
              right: _borderRight ?? BorderSide.none,
            ),
        borderRadius: _borderRadius ?? (radius != null ? BorderRadius.circular(radius!) : null),
        boxShadow: _boxShadow,
        gradient: _gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: _shape ?? BoxShape.rectangle,
      );
}

extension BoxDecorationBuilderColorExt on Color {
  BoxDecorationBuilder get bd => BoxDecorationBuilder()..color = this;
}

extension BoxDecorationBuilderExt on BoxDecorationBuilder {
  BoxDecorationBuilder asset(String assetName) => this.._image = DecorationImage(image: AssetImage(assetName));

  BoxDecorationBuilder gradient(Gradient gradient) => this.._gradient = gradient;

  BoxDecorationBuilder bg(Color? color) => this..color = color;

  BoxDecorationBuilder file(String filePath) => this.._image = DecorationImage(image: FileImage(File(filePath)));

  BoxDecorationBuilder network(String url) => this.._image = DecorationImage(image: NetworkImage(url));

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
      this.._border = Border.all(color: color, width: width, style: BorderStyle.solid);

  BoxDecorationBuilder borderColor(Color color) => this.._borderColor = color;

  BoxDecorationBuilder bl({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderLeft = BorderSide(color: color ?? _borderColor, width: width, style: style);

  BoxDecorationBuilder br({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderRight = BorderSide(color: color ?? _borderColor, width: width, style: style);

  BoxDecorationBuilder bt({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderTop = BorderSide(color: color ?? _borderColor, width: width, style: style);

  BoxDecorationBuilder bb({Color? color, double width = 1.0, BorderStyle style = BorderStyle.solid}) =>
      this.._borderBottom = BorderSide(color: color ?? _borderColor, width: width, style: style);

  BoxDecorationBuilder boxShadow(List<BoxShadow>? boxShadow) => this.._boxShadow = boxShadow;

  BoxDecorationBuilder get rectangle => this.._shape = BoxShape.rectangle;

  BoxDecorationBuilder get circle => this.._shape = BoxShape.circle;
}
