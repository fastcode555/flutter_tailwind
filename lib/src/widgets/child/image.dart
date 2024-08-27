import 'package:flutter/material.dart';
import 'package:flutter_tailwind/tailwind.dart';

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
        BorderRadiusBuilder,
        PaddingBuilder,
        ShadowBuilder {
  final String image;
  final int type;

  String? _heroTag;

  ImageBuilder._(this.image, this.type);

  @override
  Widget get mk {
    if (hasPadding) {
      return Padding(padding: finalPadding!, child: _buildImage());
    }
    return _buildImage();
  }

  Widget _buildImage() {
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
        boxShadow: boxShadow,
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
        boxShadow: boxShadow,
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
      boxShadow: boxShadow,
    );
  }

  Widget _buildAssetImage() {
    if (borderColor != null || boxShadow != null) {
      return Container(
        width: size ?? width,
        height: size ?? height,
        decoration: BoxDecoration(
          borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.zero),
          border: Border.all(color: borderColor!, width: borderWidth ?? 1.0),
          shape: shape ?? BoxShape.rectangle,
          boxShadow: boxShadow,
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
