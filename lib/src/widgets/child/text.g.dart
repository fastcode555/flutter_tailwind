part of 'text.dart';

mixin TextFeature {
  Color? _decorationColor;
  FontStyle? _fontStyle;
  String? fontFamily;
  double? _decorationThickness;
  List<String>? _fontFamilyFallback;
  double? _letterSpacing;
  double? _wordSpacing;
  double? _height;
  Locale? _locale;
  Paint? _background;
  Paint? _foreground;
  List<Shadow>? shadows;
  List<FontFeature>? _fontFeatures;
  List<FontVariation>? _fontVariations;
  TextLeadingDistribution? _leadingDistribution;
  TextDecoration? _decoration;

  TextOverflow? _overflow;
  TextDecorationStyle? _decorationStyle;
}

extension TextCommonFeatureExt<T extends TextFeature> on T {
  T fontFamilyFallback(List<String>? fontFamilyFallback) => this.._fontFamilyFallback = fontFamilyFallback;

  T letterSpacing(double? letterSpacing) => this.._letterSpacing = letterSpacing;

  T fontVariations(List<FontVariation>? fontVariations) => this.._fontVariations = fontVariations;

  T fontFeatures(List<FontFeature>? fontFeatures) => this.._fontFeatures = fontFeatures;

  T background(Paint? background) => this.._background = background;

  T bg(Paint? bg) => this.._background = bg;

  T foreground(Paint? foreground) => this.._foreground = foreground;

  T fg(Paint? fg) => this.._foreground = fg;

  T shadows(List<Shadow>? shadows) => this..shadows = shadows;

  T locale(Locale? locale) => this.._locale = locale;

  T height(double? height) => this.._height = height;

  T wordSpacing(double? wordSpacing) => this.._wordSpacing = wordSpacing;

  T get italic => this.._fontStyle = FontStyle.italic;

  T decorationColor(Color? color) => this.._decorationColor = color;

  ///TextLeadingDistribution
  T get even => this.._leadingDistribution = TextLeadingDistribution.even;

  T get proportional => this.._leadingDistribution = TextLeadingDistribution.proportional;

  ///[TextDecoration.lineThrough]
  T get lineThrough => this.._decoration = TextDecoration.lineThrough;

  ///[TextDecoration.overline]
  T get overline => this.._decoration = TextDecoration.overline;

  ///[TextDecoration.underline]
  T get underline => this.._decoration = TextDecoration.underline;

  T decoration(TextDecoration decoration) => this.._decoration = decoration;

  ///set the overflow[TextOverflow.ellipsis]
  T get ellipsis => this.._overflow = TextOverflow.ellipsis;

  ///set the overflow[TextOverflow.clip]
  T get clip => this.._overflow = TextOverflow.clip;

  ///set the overflow[TextOverflow.fade]
  T get fade => this.._overflow = TextOverflow.fade;

  ///set the overflow[TextOverflow.visible]
  T get visible => this.._overflow = TextOverflow.visible;

  ///set the decoration style [TextDecorationStyle.dashed]
  T get dashed => this.._decorationStyle = TextDecorationStyle.dashed;

  ///set the decoration style [TextDecorationStyle.dotted]
  T get dotted => this.._decorationStyle = TextDecorationStyle.dotted;

  ///set the decoration style [TextDecorationStyle.double]
  T get doubles => this.._decorationStyle = TextDecorationStyle.double;

  ///set the decoration style [TextDecorationStyle.solid]
  T get solid => this.._decorationStyle = TextDecorationStyle.solid;

  ///set the decoration style [TextDecorationStyle.wavy]
  T get wavy => this.._decorationStyle = TextDecorationStyle.wavy;
}
