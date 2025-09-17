import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/19
/// describe:
mixin BoxFitBuilder {
  BoxFit? innerFit;
}

extension BoxFitBuilderExt<T extends BoxFitBuilder> on T {
  ///[BoxFit.fill]
  T fit(BoxFit? fit) => this..innerFit = fit;

  ///[BoxFit.fill]
  T get fill => this..innerFit = BoxFit.fill;

  ///[BoxFit.contain]
  T get contain => this..innerFit = BoxFit.contain;

  ///[BoxFit.cover]
  T get cover => this..innerFit = BoxFit.cover;

  ///[BoxFit.fitWidth]
  T get fitWidth => this..innerFit = BoxFit.fitWidth;

  ///[BoxFit.fitHeight]
  T get fitHeight => this..innerFit = BoxFit.fitHeight;

  ///[BoxFit.none]
  T get none => this..innerFit = BoxFit.none;

  ///[BoxFit.scaleDown]
  T get scaleDown => this..innerFit = BoxFit.scaleDown;
}

mixin BoxShapeBuilder {
  BoxShape? innerShape;

  bool get isCircle => innerShape == BoxShape.circle;
}

extension BoxShapeBuilderExt<T extends BoxShapeBuilder> on T {
  ///[BoxShape.rectangle]
  T get rectangle => this..innerShape = BoxShape.rectangle;

  ///[BoxShape.circle]
  T get circle => this..innerShape = BoxShape.circle;
}
