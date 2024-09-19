import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/19
/// describe:
mixin BoxFitBuilder {
  BoxFit? fit;
}

extension BoxFitBuilderExt<T extends BoxFitBuilder> on T {
  ///[BoxFit.fill]
  T get fill => this..fit = BoxFit.fill;

  ///[BoxFit.contain]
  T get contain => this..fit = BoxFit.contain;

  ///[BoxFit.cover]
  T get cover => this..fit = BoxFit.cover;

  ///[BoxFit.fitWidth]
  T get fitWidth => this..fit = BoxFit.fitWidth;

  ///[BoxFit.fitHeight]
  T get fitHeight => this..fit = BoxFit.fitHeight;

  ///[BoxFit.none]
  T get none => this..fit = BoxFit.none;

  ///[BoxFit.scaleDown]
  T get scaleDown => this..fit = BoxFit.scaleDown;
}

mixin BoxShapeBuilder {
  BoxShape? shape;

  bool get isCircle => shape == BoxShape.circle;
}

extension BoxShapeBuilderExt<T extends BoxShapeBuilder> on T {
  ///[BoxShape.rectangle]
  T get rectangle => this..shape = BoxShape.rectangle;

  ///[BoxShape.circle]
  T get circle => this..shape = BoxShape.circle;
}
