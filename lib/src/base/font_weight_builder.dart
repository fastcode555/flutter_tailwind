import 'package:flutter/material.dart';

/// @date 7/11/23
/// describe:
mixin FontWeightBuilder {
  FontWeight? _fontWeight;

  FontWeight? get fontWeight => _fontWeight;

  set fontWeight(FontWeight? fontWeight) {
    _fontWeight = fontWeight;
  }
}

extension FontWeightBuilderExt<T extends FontWeightBuilder> on T {
  ///FontWeight
  T get bold => this.._fontWeight = FontWeight.bold;

  T get normal => this.._fontWeight = FontWeight.normal;

  T get w100 => this.._fontWeight = FontWeight.w100;

  T get w200 => this.._fontWeight = FontWeight.w200;

  T get w300 => this.._fontWeight = FontWeight.w300;

  T get w400 => this.._fontWeight = FontWeight.w400;

  T get w500 => this.._fontWeight = FontWeight.w500;

  T get w600 => this.._fontWeight = FontWeight.w600;

  T get w700 => this.._fontWeight = FontWeight.w700;

  T get w800 => this.._fontWeight = FontWeight.w800;

  T get w900 => this.._fontWeight = FontWeight.w900;
}
