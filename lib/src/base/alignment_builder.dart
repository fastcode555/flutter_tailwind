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

  T get topLeft => this..align(Alignment.topLeft);

  T get topCenter => this..align(Alignment.topCenter);

  T get topRight => this..align(Alignment.topRight);

  T get centerLeft => this.align(Alignment.centerLeft);

  T get center => this.align(Alignment.center);

  T get centerRight => this.align(Alignment.centerRight);

  T get bottomLeft => this.align(Alignment.bottomLeft);

  T get bottomCenter => this.align(Alignment.bottomCenter);

  T get bottomRight => this.align(Alignment.bottomRight);
}
