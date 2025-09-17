import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

///# eg:
///- R.icAirPlay.svg.black.s100.mk
///- svg(R.icAirPlay).black.s100.mk
_SvgBuilder svg(String file) => _SvgBuilder._(file);

class _SvgBuilder extends MkBuilder<Widget>
    with ColorBuilder, SizeBuilder, BlendModeBuilder, BoxFitBuilder, AlignmentBuilder, PaddingBuilder, OpacityBuilder {
  final String file;
  bool? matchTextDirection;
  bool? allowDrawingOutsideViewBox;
  bool? excludeFromSemantics;
  AssetBundle? bundle;
  String? package;
  String? semanticsLabel;
  SvgTheme? theme;
  Clip? clipBehavior;
  WidgetBuilder? placeholderBuilder;

  _SvgBuilder._(this.file);

  ColorFilter? get _finalColorFilter {
    if (innerColor == null) return null;
    return ColorFilter.mode(innerColor.opacity(innerOpacity)!, innerBlendMode ?? BlendMode.srcIn);
  }

  @override
  Widget get mk {
    return createPadding(
      SvgPicture.asset(
        file,
        width: size ?? width,
        bundle: bundle,
        height: size ?? height,
        fit: innerFit ?? BoxFit.contain,
        excludeFromSemantics: excludeFromSemantics ?? false,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? false,
        matchTextDirection: matchTextDirection ?? false,
        alignment: alignment ?? Alignment.center,
        semanticsLabel: semanticsLabel,
        theme: theme,
        placeholderBuilder: placeholderBuilder,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        colorFilter: _finalColorFilter,
      ),
    );
  }
}

extension SvgStringExt on String? {
  ///# eg:
  ///- R.icAirPlay.svg.black.s100.mk
  ///- svg(R.icAirPlay).black.s100.mk
  _SvgBuilder get svg => _SvgBuilder._(this ?? '');
}

extension SvgBuilderExt<T extends _SvgBuilder> on T {
  T size(double size) => this..size = size;

  T width(double size) => this..width = size;

  T height(double size) => this..height = size;

  T matchTextDirection(bool value) => this..matchTextDirection = value;

  T allowDrawingOutsideViewBox(bool value) => this..allowDrawingOutsideViewBox = value;

  T excludeFromSemantics(bool value) => this..excludeFromSemantics = value;

  T bundle(AssetBundle bundle) => this..bundle = bundle;

  T package(String package) => this..package = package;

  T placeholderBuilder(WidgetBuilder placeholderBuilder) => this..placeholderBuilder = placeholderBuilder;

  T theme(SvgTheme? theme) => this..theme = theme;
}
