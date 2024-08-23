import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/alignment_builder.dart';
import 'package:flutter_tailwind/src/base/blend_mode_builder.dart';
import 'package:flutter_tailwind/src/base/border_color_builder.dart';
import 'package:flutter_tailwind/src/base/border_radius_builder.dart';
import 'package:flutter_tailwind/src/base/border_width_builder.dart';
import 'package:flutter_tailwind/src/base/image_feature.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/src/base/size_builder.dart';

/// Barry
/// @date 2024/8/19
/// describe:

int _asset = 0;
int _file = 1;
int _network = 2;

///Image.asset
ImageBuilder assetImage(String path) => ImageBuilder._(path, _asset);

///Image.file
ImageBuilder fileImage(String path) => ImageBuilder._(path, _file);

///Image.network
ImageBuilder netImage(String path) => ImageBuilder._(path, _network);

extension StringImageTailWind on String {
  ///Image.asset
  ImageBuilder get asset => ImageBuilder._(this, _asset);

  ///Image.file
  ImageBuilder get file => ImageBuilder._(this, _file);

  ///Image.network
  ImageBuilder get network => ImageBuilder._(this, _network);
}

class ImageBuilder extends MkBuilder<Widget>
    with
        SizeBuilder,
        BoxFitBuilder,
        AlignmentBuilder,
        BoxShapeBuilder,
        BlendModeBuilder,
        BorderWidthBuilder,
        BorderColorBuilder,
        BorderRadiusBuilder {
  final String image;
  final int type;

  ImageBuilder._(this.image, this.type);

  @override
  Widget get mk => _buildBorderImage();

  Widget _buildImage() {
    if (isCircle) {
      return buildCircleImage();
    }
    double? finalW = size ?? width;
    double? finalH = size ?? height;
    double localBorder = (borderWidth ?? (borderColor != null ? 1.0 : 0));
    if (finalW != null) {
      finalW = finalW - localBorder * 2;
    }
    if (finalH != null) {
      finalH = finalH - localBorder * 2;
    }
    if (type == _network || image.startsWith("http")) {
      return Image.network(
        image,
        width: finalW,
        height: finalH,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        colorBlendMode: blendMode,
      );
    } else if (type == _file) {
      return Image.file(
        File(image),
        width: finalW,
        height: finalH,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        colorBlendMode: blendMode,
      );
    }
    return Image.asset(
      image,
      width: finalW,
      height: finalH,
      fit: fit ?? BoxFit.cover,
      alignment: alignment ?? Alignment.center,
      colorBlendMode: blendMode,
    );
  }

  ImageProvider _buildProvideImage() {
    if (type == _network || image.startsWith("http")) {
      return NetworkImage(image);
    } else if (type == _file) {
      return FileImage(File(image));
    }
    return AssetImage(image);
  }

  ///建一个圆形的图片
  Widget buildCircleImage() {
    double radius = _getRadius();
    radius = radius - (borderWidth ?? (borderColor != null ? 1.0 : 0.0));
    if (type == _network || image.startsWith("http")) {
      return CircleAvatar(backgroundImage: NetworkImage(image), radius: radius);
    } else if (type == _file) {
      return CircleAvatar(backgroundImage: FileImage(File(image)), radius: radius);
    }
    return CircleAvatar(backgroundImage: AssetImage(image), radius: radius);
  }

  ///计算,获取半径的大小
  double _getRadius() {
    if (size != null && size! > 0) {
      return size! / 2;
    }
    double finalW = width ?? 0.0;
    double finalH = height ?? 0.0;
    double minSize = min(finalW, finalH);
    if (minSize > 0) {
      return minSize / 2;
    }
    return max(finalW, finalH) / 2;
  }

  ///给图片建边框
  Widget _buildBorderImage() {
    if (borderColor != null) {
      return Container(
        width: size ?? width,
        height: size ?? height,
        decoration: BoxDecoration(
          borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.zero),
          border: Border.all(color: borderColor!, width: borderWidth ?? 1.0),
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: _buildProvideImage(),
            fit: fit ?? BoxFit.cover,
            alignment: alignment ?? Alignment.center,
          ),
        ),
      );
    }
    Widget imageWidget = _buildImage();
    if (hasRadius) {
      imageWidget = ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }
    return imageWidget;
  }
}
