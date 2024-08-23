import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/alignment_builder.dart';
import 'package:flutter_tailwind/src/base/blend_mode_builder.dart';
import 'package:flutter_tailwind/src/base/border_color_builder.dart';
import 'package:flutter_tailwind/src/base/border_radius_builder.dart';
import 'package:flutter_tailwind/src/base/border_width_builder.dart';
import 'package:flutter_tailwind/src/base/image_feature.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/src/base/size_builder.dart';
import 'package:flutter_tailwind/src/config/image_loader_config.dart';
import 'package:flutter_tailwind/src/tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

int _asset = 0;
int _image = 1;

///Image.asset
ImageBuilder assetImage(String path) => ImageBuilder._(path, _asset);

///Image.network
ImageBuilder image(String path) => ImageBuilder._(path, _image);

extension StringImageTailWind on String {
  ///Image.asset
  ImageBuilder get asset => ImageBuilder._(this, _asset);

  ///Image.network
  ImageBuilder get network => ImageBuilder._(this, _image);
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

  ImageLoaderConfig? get _config => Tailwind.instance.imageConfig;
}
