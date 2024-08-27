import 'package:flutter/material.dart';

/// Barry
/// @date 7/11/23
/// describe:

mixin TextDirectionBuilder {
  TextDirection? textDirection;
}

mixin TextBaselineBuilder {
  TextBaseline? textBaseline;
}

extension TextBaselineBuilderExt<T extends TextBaselineBuilder> on T {
  ///BaseLine
  T get alphabetic => this..textBaseline = TextBaseline.alphabetic;

  T get ideographic => this..textBaseline = TextBaseline.ideographic;
}

extension TextDirectionBuilderExt<T extends TextDirectionBuilder> on T {
  T get rtl => this..textDirection = TextDirection.rtl;

  T get ltr => this..textDirection = TextDirection.ltr;
}

mixin TextAlignBuilder {
  TextAlign? textAlign;
}

extension TextAlignBuilderExt<T extends TextAlignBuilder> on T {
  T get center => this..textAlign = TextAlign.center;

  T get left => this..textAlign = TextAlign.left;

  T get right => this..textAlign = TextAlign.right;

  T get justify => this..textAlign = TextAlign.justify;

  T get start => this..textAlign = TextAlign.start;

  T get end => this..textAlign = TextAlign.end;
}

mixin FontWeightBuilder {
  FontWeight? fontWeight;
}

// Tailwind font-thin (100) 对应 Flutter FontWeight.w100
// Tailwind font-extralight (200) 对应 Flutter FontWeight.w200
// Tailwind font-light (300) 对应 Flutter FontWeight.w300
// Tailwind font-normal (400) 对应 Flutter FontWeight.w400 或 FontWeight.normal
// Tailwind font-medium (500) 对应 Flutter FontWeight.w500
// Tailwind font-semibold (600) 对应 Flutter FontWeight.w600
// Tailwind font-bold (700) 对应 Flutter FontWeight.w700 或 FontWeight.bold
// Tailwind font-extrabold (800) 对应 Flutter FontWeight.w800
// Tailwind font-black (900) 对应 Flutter FontWeight.w900
extension FontWeightBuilderExt<T extends FontWeightBuilder> on T {
  ///FontWeight

  T get w100 => this..fontWeight = FontWeight.w100;

  T get w200 => this..fontWeight = FontWeight.w200;

  T get w300 => this..fontWeight = FontWeight.w300;

  T get w400 => this..fontWeight = FontWeight.w400;

  T get w500 => this..fontWeight = FontWeight.w500;

  T get w600 => this..fontWeight = FontWeight.w600;

  T get w700 => this..fontWeight = FontWeight.w700;

  T get w800 => this..fontWeight = FontWeight.w800;

  T get w900 => this..fontWeight = FontWeight.w900;

  T get thin => this..fontWeight = FontWeight.w100;

  T get extralight => this..fontWeight = FontWeight.w200;

  T get light => this..fontWeight = FontWeight.w300;

  T get normal => this..fontWeight = FontWeight.normal;

  T get medium => this..fontWeight = FontWeight.w500;

  T get semibold => this..fontWeight = FontWeight.w600;

  T get bold => this..fontWeight = FontWeight.bold;

  T get extrabold => this..fontWeight = FontWeight.w800;

  T get fontBlack => this..fontWeight = FontWeight.w900;
}

mixin TextFeature {
  Color? decorationColor;
  FontStyle? fontStyle;
  String? fontFamily;
  double? decorationThickness;
  List<String>? fontFamilyFallback;
  double? letterSpacing;
  double? wordSpacing;
  double? height;
  Locale? locale;
  Paint? background;
  Paint? foreground;
  List<Shadow>? shadows;
  List<FontFeature>? fontFeatures;
  List<FontVariation>? fontVariations;
  TextLeadingDistribution? leadingDistribution;
  TextDecoration? decoration;
  TextOverflow? overflow;
  TextDecorationStyle? decorationStyle;
}

extension TextCommonFeatureExt<T extends TextFeature> on T {
  T fontFamilyFallback(List<String>? fontFamilyFallback) => this..fontFamilyFallback = fontFamilyFallback;

  T letterSpacing(double? letterSpacing) => this..letterSpacing = letterSpacing;

  T fontVariations(List<FontVariation>? fontVariations) => this..fontVariations = fontVariations;

  T fontFeatures(List<FontFeature>? fontFeatures) => this..fontFeatures = fontFeatures;

  T background(Paint? background) => this..background = background;

  T bg(Paint? bg) => this..background = bg;

  T foreground(Paint? foreground) => this..foreground = foreground;

  T fg(Paint? fg) => this..foreground = fg;

  T shadows(List<Shadow>? shadows) => this..shadows = shadows;

  T locale(Locale? locale) => this..locale = locale;

  T height(double? height) => this..height = height;

  T wordSpacing(double? wordSpacing) => this..wordSpacing = wordSpacing;

  T get italic => this..fontStyle = FontStyle.italic;

  T decorationColor(Color? color) => this..decorationColor = color;

  ///TextLeadingDistribution
  T get even => this..leadingDistribution = TextLeadingDistribution.even;

  T get proportional => this..leadingDistribution = TextLeadingDistribution.proportional;

  ///TextDecoration
  T get lineThrough => this..decoration = TextDecoration.lineThrough;

  T get overline => this..decoration = TextDecoration.overline;

  T get underline => this..decoration = TextDecoration.underline;

  ///TextOverflow
  T get ellipsis => this..overflow = TextOverflow.ellipsis;

  T get clip => this..overflow = TextOverflow.clip;

  T get fade => this..overflow = TextOverflow.fade;

  T get visible => this..overflow = TextOverflow.visible;

  ///TextDecorationStyle
  T get dashed => this..decorationStyle = TextDecorationStyle.dashed;

  T get dotted => this..decorationStyle = TextDecorationStyle.dotted;

  T get doubles => this..decorationStyle = TextDecorationStyle.double;

  T get solid => this..decorationStyle = TextDecorationStyle.solid;

  T get wavy => this..decorationStyle = TextDecorationStyle.wavy;
}
