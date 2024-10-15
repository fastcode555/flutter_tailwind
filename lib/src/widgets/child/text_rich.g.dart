part of 'text.dart';

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
        ExpandedBuilder,
        TextColorBuilder,
        OpacityBuilder {
  RichTextBuilder._();

  @override
  Widget children(List<InlineSpan>? children) {
    var child = createPadding(
      Text.rich(
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
        maxLines: innerMaxLines,
        softWrap: _softWrap,
      ),
    );
    return createExpanded(child);
  }
}
