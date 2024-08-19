import 'package:flutter/material.dart';

import 'base/color_builder.dart';
import 'base/font_size_builder.dart';
import 'base/font_weight_builder.dart';

/// Barry
/// @date 4/11/23
/// describe: A bit like Csstailwind or chain programming like ios swift
/// 有点像Csstailwind或者像ios swift的链式编程

TextStyleBuilder get ts => TextStyleBuilder();

class TextStyleBuilder with ColorBuilder, FontSizeBuilder, FontWeightBuilder {
  Color? _decorationColor;
  TextDecoration? _decoration;
  FontStyle? _fontStyle;
  String? _fontFamily;
  double? _decorationThickness;
  TextDecorationStyle? _decorationStyle;
  TextBaseline? _textBaseline;
  List<String>? _fontFamilyFallback;
  double? _letterSpacing;
  double? _wordSpacing;
  double? _height;
  TextLeadingDistribution? _leadingDistribution;
  Locale? _locale;
  Paint? _background;
  Paint? _foreground;
  List<Shadow>? _shadows;
  List<FontFeature>? _fontFeatures;
  List<FontVariation>? _fontVariations;
  TextOverflow? _overflow;

  // TextStyle get make => mk;

  ///mk = make = create
  TextStyle get mk => TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: _decoration,
        overflow: _overflow,
        decorationStyle: _decorationStyle,
        decorationColor: _decorationColor,
        fontStyle: _fontStyle,
        fontFamily: _fontFamily,
        decorationThickness: _decorationThickness,
        fontWeight: fontWeight,
        textBaseline: _textBaseline,
        fontFamilyFallback: _fontFamilyFallback,
        letterSpacing: _letterSpacing,
        wordSpacing: _wordSpacing,
        height: _height,
        leadingDistribution: _leadingDistribution,
        locale: _locale,
        background: _background,
        foreground: _foreground,
        shadows: _shadows,
        fontFeatures: _fontFeatures,
        fontVariations: _fontVariations,
      );
}

extension TextStyleBuilderColorExt on Color {
  TextStyleBuilder get ts => TextStyleBuilder()..color = this;
}

extension TextStyleBuilderDoubleExt on double {
  TextStyleBuilder get ts => TextStyleBuilder()..fontSize = this;
}

extension TextStyleBuilderIntExt on int {
  TextStyleBuilder get ts => TextStyleBuilder()..fontSize = toDouble();
}

extension TextStyleBuilderExt on TextStyleBuilder {
  TextStyleBuilder fontFamilyFallback(List<String>? fontFamilyFallback) =>
      this.._fontFamilyFallback = fontFamilyFallback;

  TextStyleBuilder letterSpacing(double? letterSpacing) => this.._letterSpacing = letterSpacing;

  TextStyleBuilder fontVariations(List<FontVariation>? fontVariations) => this.._fontVariations = fontVariations;

  TextStyleBuilder fontFeatures(List<FontFeature>? fontFeatures) => this.._fontFeatures = fontFeatures;

  TextStyleBuilder background(Paint? background) => this.._background = background;

  TextStyleBuilder bg(Paint? bg) => this.._background = bg;

  TextStyleBuilder foreground(Paint? foreground) => this.._foreground = foreground;

  TextStyleBuilder fg(Paint? fg) => this.._foreground = fg;

  TextStyleBuilder shadows(List<Shadow>? shadows) => this.._shadows = shadows;

  TextStyleBuilder locale(Locale? locale) => this.._locale = locale;

  ///TextLeadingDistribution
  TextStyleBuilder get even => this.._leadingDistribution = TextLeadingDistribution.even;

  TextStyleBuilder get proportional => this.._leadingDistribution = TextLeadingDistribution.proportional;

  TextStyleBuilder height(double? height) => this.._height = height;

  TextStyleBuilder wordSpacing(double? wordSpacing) => this.._wordSpacing = wordSpacing;

  ///TextOverflow
  TextStyleBuilder get ellipsis => this.._overflow = TextOverflow.ellipsis;

  TextStyleBuilder get clip => this.._overflow = TextOverflow.clip;

  TextStyleBuilder get fade => this.._overflow = TextOverflow.fade;

  TextStyleBuilder get visible => this.._overflow = TextOverflow.visible;

  ///TextBaseline
  TextStyleBuilder get alphabetic => this.._textBaseline = TextBaseline.alphabetic;

  TextStyleBuilder get ideographic => this.._textBaseline = TextBaseline.ideographic;

  ///TextDecorationStyle
  TextStyleBuilder get dashed => this.._decorationStyle = TextDecorationStyle.dashed;

  TextStyleBuilder get dotted => this.._decorationStyle = TextDecorationStyle.dotted;

  TextStyleBuilder get doubles => this.._decorationStyle = TextDecorationStyle.double;

  TextStyleBuilder get solid => this.._decorationStyle = TextDecorationStyle.solid;

  TextStyleBuilder get wavy => this.._decorationStyle = TextDecorationStyle.wavy;

  TextStyleBuilder get italic => this.._fontStyle = FontStyle.italic;

  ///TextDecoration
  TextStyleBuilder get lineThrough => this.._decoration = TextDecoration.lineThrough;

  TextStyleBuilder get overline => this.._decoration = TextDecoration.overline;

  TextStyleBuilder get underline => this.._decoration = TextDecoration.underline;

  TextStyleBuilder fontFamily(String? fontFamily) => this.._fontFamily = fontFamily;

  TextStyleBuilder decorationColor(Color? color) => this.._decorationColor = color;
}
