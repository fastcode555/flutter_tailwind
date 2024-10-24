import 'package:flutter/material.dart';

/// Barry
/// @date 2024/10/24
/// describe:

mixin KeyBuilder {
  Key? innerKey;
}

extension KeyBuilderMixin<T extends KeyBuilder> on T {
  T key(Key? key) => this..innerKey = key;
}
