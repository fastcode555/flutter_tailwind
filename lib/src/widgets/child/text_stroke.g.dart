part of 'text.dart';

class StrokeTextBuilder extends MkBuilder<Widget>
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
        ExpandedBuilder,
        OpacityBuilder {
  final String? value;

  StrokeTextBuilder._(this.value);

  @override
  Widget get mk {
    var child = createPadding(
      Stack(
        children: [
          Text(
            value ?? '',
            style: style ??
                TextStyle(
                  fontSize: fontSize,
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
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = innerColors.get(1).opacity(innerOpacity) ?? Colors.orange,
                  shadows: shadows,
                  fontFeatures: _fontFeatures,
                  fontVariations: _fontVariations,
                ),
            textAlign: textAlign,
            textDirection: textDirection,
            maxLines: innerMaxLines,
            softWrap: _softWrap,
          ),
          Text(
            value ?? '',
            style: style ??
                TextStyle(
                  fontSize: fontSize,
                  color: innerColors.get(0).opacity(innerOpacity),
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
            maxLines: innerMaxLines,
            softWrap: _softWrap,
          ),
        ],
      ),
    );
    return createExpanded(child);
  }
}
