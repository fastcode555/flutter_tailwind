import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/utils/list_ext.dart';

part 'text.g.dart';
part 'text_rich.g.dart';
part 'text_stroke.g.dart';
part 'text_style.g.dart';

/// Barry
/// @date 2024/8/19
/// describe: A bit like Csstailwind or chain programming like ios swift
/// 有点像Csstailwind或者像ios swift的链式编程

mixin CompletedTextStyleBuilder {
  TextStyle? style;
}

///[Text]
///# eg:
///- 'Hello-world'.text.dashed.lightGreen.f30.bold.lineThrough.mk
///- text('Hello-world').dashed.lightGreen.f30.bold.lineThrough.mk
///![](https://github.com/fastcode555/flutter_tailwind/blob/master/images/text_image.png?raw=true)
TextBuilder text(String? value) => TextBuilder._(value ?? '');

///[Text.rich]
RichTextBuilder get textRich => RichTextBuilder._();

StrokeTextBuilder strokeText(String? value) => StrokeTextBuilder._(value ?? '');

extension TextBuilderStringExt on String? {
  ///[Text]
  ///# eg:
  ///- 'Hello-world'.text.dashed.lightGreen.f30.bold.lineThrough.mk
  ///- text('Hello-world').dashed.lightGreen.f30.bold.lineThrough.mk
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/images/text_image.png?raw=true)
  TextBuilder get text => TextBuilder._(this ?? '');

  StrokeTextBuilder get strokeText => StrokeTextBuilder._(this ?? '');
}

TextStyleBuilder get ts => TextStyleBuilder();

///[Text]
class TextBuilder extends MkBuilder<Widget>
    with
        TextAlignBuilder,
        ColorBuilder,
        FontSizeBuilder,
        FontWeightBuilder,
        TextFeature,
        MaxLineBuilder,
        TextDirectionBuilder,
        CompletedTextStyleBuilder,
        TextBaselineBuilder,
        PaddingBuilder,
        TextColorBuilder,
        ExpandedBuilder,
        OpacityBuilder {
  final String? value;

  TextBuilder._(this.value);

  TextStyle get _style =>
      style /*?.copyWith(
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
            ) */
      ??
      TextStyle(
        fontSize: _useAutoSize ? maxFontSize : fontSize,
        color: innerTextColor.opacity(innerOpacity) ?? innerColor.opacity(innerOpacity),
        decoration: _decoration,
        overflow: _overflow,
        decorationStyle: _decorationStyle,
        decorationColor: _decorationColor.opacity(innerOpacity),
        fontStyle: _fontStyle,
        fontFamily: fontFamily,
        decorationThickness: _decorationThickness,
        fontWeight: fontWeight,
        textBaseline: textBaseline,
        fontFamilyFallback: _fontFamilyFallback,
        letterSpacing: _letterSpacing,
        wordSpacing: _wordSpacing,
        height: _height,
        leadingDistribution: _leadingDistribution,
        locale: _locale,
        background: _background,
        foreground: _foreground,
        shadows: shadows,
        fontFeatures: _fontFeatures,
        fontVariations: _fontVariations,
      );

  bool get _useAutoSize => fontSizes != null && fontSizes?.length == 2 && fontSizes?[0] != fontSizes?[1];

  double get maxFontSize => max(fontSizes![0], fontSizes![1]);

  @override
  Widget get mk {
    late Widget child;
    if (_useAutoSize) {
      final minFontSize = min(fontSizes![0], fontSizes![1]).round().toDouble();
      child = AutoSizeText(
        value ?? '',
        minFontSize: minFontSize,
        style: _style,
        textAlign: textAlign,
        softWrap: _softWrap,
        textDirection: textDirection,
        maxLines: innerMaxLines,
      );
    } else {
      child = Text(
        value ?? '',
        style: _style,
        textAlign: textAlign,
        softWrap: _softWrap,
        textDirection: textDirection,
        maxLines: innerMaxLines,
      );
    }
    child = createPadding(child);
    return createExpanded(child);
  }
}
