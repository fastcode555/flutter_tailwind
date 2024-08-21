import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/src/base/alignment_builder.dart';
import 'package:flutter_tailwind/src/base/blend_mode_builder.dart';
import 'package:flutter_tailwind/src/base/color_builder.dart';
import 'package:flutter_tailwind/src/base/image_feature.dart';
import 'package:flutter_tailwind/src/base/size_builder.dart';

import '../base/mk_builder.dart';

/// Barry
/// @date 2024/8/19
/// describe:

SvgBuilder svg(String file) => SvgBuilder(file);

class SvgBuilder extends MkBuilder<SvgPicture>
    with ColorBuilder, SizeBuilder, BlendModeBuilder, BoxFitBuilder, AlignmentBuilder {
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

  SvgBuilder(this.file);

  @override
  SvgPicture get mk => SvgPicture.asset(
        file,
        width: size ?? width,
        bundle: bundle,
        height: size ?? height,
        fit: fit ?? BoxFit.contain,
        excludeFromSemantics: excludeFromSemantics ?? false,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox ?? false,
        matchTextDirection: matchTextDirection ?? false,
        alignment: alignment ?? Alignment.center,
        semanticsLabel: semanticsLabel,
        theme: theme,
        placeholderBuilder: placeholderBuilder,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        colorFilter: color != null ? ColorFilter.mode(color!, blendMode ?? BlendMode.srcIn) : null,
      );
}

extension SvgBuilderExt<T extends SvgBuilder> on T {
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
