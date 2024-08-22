import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

import '../base/mk_builder.dart';

/// Barry
/// @date 2024/8/19
/// describe: A bit like Csstailwind or chain programming like ios swift
/// 有点像Csstailwind或者像ios swift的链式编程

TextBuilder text(String value) => TextBuilder._(value);

extension TextBuilderStringExt on String? {
  TextBuilder get text => TextBuilder._(this ?? "");
}

TextStyleBuilder get ts => TextStyleBuilder();

class TextStyleBuilder extends MkBuilder<TextStyle>
    with ColorBuilder, FontSizeBuilder, FontWeightBuilder, TextCommonFeature {
  @override
  TextStyle get mk => TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        overflow: overflow,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        decorationThickness: decorationThickness,
        fontWeight: fontWeight,
        textBaseline: textBaseline,
        fontFamilyFallback: fontFamilyFallback,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        background: background,
        foreground: foreground,
        shadows: shadows,
        fontFeatures: fontFeatures,
        fontVariations: fontVariations,
      );
}

class TextBuilder extends MkBuilder<Text>
    with
        TextAlignBuilder,
        ColorBuilder,
        FontSizeBuilder,
        FontWeightBuilder,
        TextCommonFeature,
        MaxLineBuilder,
        TextDirectionBuilder {
  final String? value;

  TextBuilder._(this.value);

  @override
  Text get mk => Text(
        value ?? "",
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          decoration: decoration,
          overflow: overflow,
          decorationStyle: decorationStyle,
          decorationColor: decorationColor,
          fontStyle: fontStyle,
          fontFamily: fontFamily,
          decorationThickness: decorationThickness,
          fontWeight: fontWeight,
          textBaseline: textBaseline,
          fontFamilyFallback: fontFamilyFallback,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          height: height,
          leadingDistribution: leadingDistribution,
          locale: locale,
          background: background,
          foreground: foreground,
          shadows: shadows,
          fontFeatures: fontFeatures,
          fontVariations: fontVariations,
        ),
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
      );
}
