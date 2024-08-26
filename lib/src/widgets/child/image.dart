import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/base/alignment_builder.dart';
import 'package:flutter_tailwind/src/base/blend_mode_builder.dart';
import 'package:flutter_tailwind/src/base/border_color_builder.dart';
import 'package:flutter_tailwind/src/base/border_radius_builder.dart';
import 'package:flutter_tailwind/src/base/border_width_builder.dart';
import 'package:flutter_tailwind/src/base/image_feature.dart';
import 'package:flutter_tailwind/src/base/mk_builder.dart';
import 'package:flutter_tailwind/src/base/size_builder.dart';
import 'package:flutter_tailwind/src/imageloader/image_loader.dart';

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
  ImageBuilder get image => ImageBuilder._(this, _image);
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

  String? _heroTag;

  ImageBuilder._(this.image, this.type);

  @override
  Widget get mk {
    if (type == _asset) {
      if (_heroTag != null && _heroTag!.isNotEmpty) {
        return Hero(tag: _heroTag!, child: _buildAssetImage());
      }
      return _buildAssetImage();
    }
    if (isCircle) {
      return ImageLoader.circle(
        image,
        fit: fit ?? BoxFit.cover,
        radius: (size ?? 0) / 2,
        borderColor: borderColor,
        border: borderWidth,
        heroTag: _heroTag,
      );
    }
    if (hasRadius) {
      return ImageLoader.round(
        image,
        fit: fit ?? BoxFit.cover,
        radius: radius,
        width: size ?? width,
        height: size ?? height,
        heroTag: _heroTag,
        borderColor: borderColor,
        border: borderWidth,
      );
    }
    return ImageLoader.image(
      image,
      fit: fit ?? BoxFit.cover,
      width: size ?? width,
      height: size ?? height,
      heroTag: _heroTag,
      borderColor: borderColor,
      border: borderWidth,
    );
  }

  Widget _buildAssetImage() {
    if (borderColor != null) {
      return Container(
        width: size ?? width,
        height: size ?? height,
        decoration: BoxDecoration(
          borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.zero),
          border: Border.all(color: borderColor!, width: borderWidth ?? 1.0),
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage(image),
            fit: fit ?? BoxFit.cover,
            alignment: alignment ?? Alignment.center,
          ),
        ),
      );
    }
    if (isCircle) {
      return CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: (size ?? width ?? height ?? 0.0) / 2,
      );
    }
    return Image.asset(
      image,
      width: size ?? width,
      height: size ?? height,
      alignment: alignment ?? Alignment.center,
    );
  }
}
