import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// @date 2024/12/27
/// describe:

class ExtendImageFactory extends BaseImageFactory {
  @override
  Widget loadCircleImage(
    String? image, {
    required BoxFit fit,
    required double radius,
    Color? borderColor,
    double? border,
    String? heroTag,
    List<BoxShadow>? boxShadow,
  }) {
    return ExtendedImage.network(
      image ?? '',
      width: radius * 2,
      height: radius * 2,
      fit: fit,
      border: borderColor != null ? Border.all(color: borderColor, width: border ?? 0) : null,
      shape: BoxShape.circle,
    );
  }

  @override
  Widget loadImage(
    String? image, {
    required BoxFit fit,
    double? width,
    double? height,
    String? heroTag,
    Color? borderColor,
    double? border,
    List<BoxShadow>? boxShadow,
  }) {
    return ExtendedImage.network(
      image ?? '',
      width: width,
      height: height,
      fit: fit,
      border: borderColor != null ? Border.all(color: borderColor, width: border ?? 0) : null,
    );
  }

  @override
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
  }) {
    BorderRadius? finalBorderRadius;
    if (borderRadius != null && borderRadius is BorderRadius) {
      finalBorderRadius = borderRadius;
    }
    if (radius != null) {
      finalBorderRadius = BorderRadius.circular(radius);
    }
    return ClipRRect(
      borderRadius: finalBorderRadius!,
      child: ExtendedImage.network(
        image ?? '',
        width: width,
        height: height,
        fit: fit,
        border: borderColor != null ? Border.all(color: borderColor, width: border ?? 0) : null,
        borderRadius: finalBorderRadius,
      ),
    );
  }
}
