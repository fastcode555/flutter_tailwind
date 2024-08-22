import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/src/base/alignment_builder.dart';
import 'package:flutter_tailwind/src/base/blend_mode_builder.dart';
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
    with SizeBuilder, BoxFitBuilder, AlignmentBuilder, BoxShapeBuilder, BlendModeBuilder {
  final String image;
  final int type;

  ImageBuilder._(this.image, this.type);

  @override
  Widget get mk => _buildImage();

  Widget _buildImage() {
    if (type == _network || image.startsWith("http")) {
      return Image.network(
        image,
        width: size ?? width,
        height: size ?? height,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        colorBlendMode: blendMode,
      );
    } else if (type == _file) {
      return Image.file(
        File(image),
        width: size ?? width,
        height: size ?? height,
        fit: fit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        colorBlendMode: blendMode,
      );
    }
    return Image.asset(
      image,
      width: size ?? width,
      height: size ?? height,
      fit: fit ?? BoxFit.cover,
      alignment: alignment ?? Alignment.center,
      colorBlendMode: blendMode,
    );
  }
}
