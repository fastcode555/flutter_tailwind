import 'dart:ui';

import 'package:flutter/src/painting/border_radius.dart';
import 'package:flutter/src/painting/box_fit.dart';
import 'package:flutter/src/painting/box_shadow.dart';
import 'package:flutter/src/widgets/framework.dart';

/// @date 2024/12/27
/// describe:
abstract class BaseImageFactory {
  Widget loadCircleImage(
    String? image, {
    required BoxFit fit,
    required double radius,
    Color? borderColor,
    double? border,
    String? heroTag,
    List<BoxShadow>? boxShadow,
  });

  Widget loadRound(
    String? image, {
    required BoxFit fit,
    double? radius,
    BorderRadiusGeometry? borderRadius,
    double? width,
    double? height,
    String? heroTag,
    Color? borderColor,
    double? border,
    List<BoxShadow>? boxShadow,
  });

  Widget loadImage(
    String? image, {
    required BoxFit fit,
    double? width,
    double? height,
    String? heroTag,
    Color? borderColor,
    double? border,
    List<BoxShadow>? boxShadow,
  });
}
