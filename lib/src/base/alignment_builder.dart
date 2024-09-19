import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/20
/// describe:
mixin AlignmentBuilder {
  Alignment? alignment;
  List<Alignment>? alignments;
}

extension AlignmentBuilderExt<T extends AlignmentBuilder> on T {
  T align(Alignment? alignment) {
    //only use two time, will create a list to collect the aligment
    if (this.alignment != null) {
      alignments ??= [];
      alignments?.add(this.alignment!);
    }
    if (alignment != null) {
      alignments?.add(alignment);
    }
    return this..alignment = alignment;
  }

  /// Alignment.topLeft
  T get topLeft => this..align(Alignment.topLeft);

  /// Alignment.topCenter
  T get topCenter => this..align(Alignment.topCenter);

  /// Alignment.topRight
  T get topRight => this..align(Alignment.topRight);

  /// Alignment.centerLeft
  T get centerLeft => this..align(Alignment.centerLeft);

  /// Alignment.center
  T get center => this..align(Alignment.center);

  /// Alignment.centerRight
  T get centerRight => this..align(Alignment.centerRight);

  /// Alignment.bottomLeft
  T get bottomLeft => this..align(Alignment.bottomLeft);

  /// Alignment.bottomCenter
  T get bottomCenter => this..align(Alignment.bottomCenter);

  /// Alignment.bottomRight
  T get bottomRight => this..align(Alignment.bottomRight);
}
