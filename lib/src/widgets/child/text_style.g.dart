part of 'text.dart';

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
