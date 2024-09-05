import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

part 'text.g.dart';

/// Barry
/// @date 2024/8/19
/// describe: A bit like Csstailwind or chain programming like ios swift
/// 有点像Csstailwind或者像ios swift的链式编程

mixin CompletedTextStyleBuilder {
  TextStyle? style;
}

///[Text]
TextBuilder text(String value) => TextBuilder._(value);

///[Text.rich]
RichTextBuilder get textRich => RichTextBuilder._();

extension TextBuilderStringExt on String? {
  ///[Text]
  TextBuilder get text => TextBuilder._(this ?? '');
}

TextStyleBuilder get ts => TextStyleBuilder();

///[TextStyle]
class TextStyleBuilder extends MkBuilder<TextStyle>
    with
        ColorBuilder,
        FontSizeBuilder,
        FontWeightBuilder,
        TextFeature,
        CompletedTextStyleBuilder,
        TextBaselineBuilder,
        TextColorBuilder,
        OpacityBuilder {
  @override
  TextStyle get mk {
    if (style != null) {
      return style! /*.copyWith(
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
      )*/
          ;
    }
    return TextStyle(
      fontSize: fontSize,
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
  }
}

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
        OpacityBuilder {
  final String? value;

  TextBuilder._(this.value);

  @override
  Widget get mk {
    Widget child = Text(
      value ?? '',
      style:
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
                fontSize: fontSize,
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
              ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
    );
    if (hasPadding) {
      return Padding(padding: finalPadding!, child: child);
    }
    return child;
  }
}

class RichTextBuilder extends ChildrenSpanBuilder<Widget>
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
        OpacityBuilder {
  RichTextBuilder._();

  @override
  Widget children(List<InlineSpan>? children) {
    Widget child = Text.rich(
      TextSpan(children: children),
      style: style ??
          TextStyle(
            fontSize: fontSize,
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
          ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
    );
    if (hasPadding) {
      return Padding(padding: finalPadding!, child: child);
    }
    return child;
  }
}
