import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/8/19
/// describe:

int _asset = 0;
int _image = 1;

///[Image.asset]
ImageBuilder asset(String? path) => ImageBuilder._(path, _asset);

///[ImageLoader.image]
ImageBuilder image(String? path) => ImageBuilder._(path, _image);

extension ImageBuilderExt<T extends ImageBuilder> on T {
  T get singleCache => this.._singleCache = true;
}

extension StringImageTailWind on String {
  ///[Image.asset]
  ///# eg:
  ///- R.icDefPlaylist.asset.border2.borderLightGreen.s100.mk,
  ///- asset(R.icDefPlaylist).border2.borderLightGreen.s100.mk,
  ///
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/image_and_icon_image.png?raw=true)
  ImageBuilder get asset => ImageBuilder._(this, _asset);

  ///
  /// [ImageLoader.image]
  /// # eg:
  /// - link.image.borderPink.border5.s100.mk
  /// - image(link).borderPink.border5.s100.mk
  ///
  ///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/url_image.png?raw=true)
  ImageBuilder get image => ImageBuilder._(this, _image);
}

///![](https://github.com/fastcode555/flutter_tailwind/blob/master/link_image/image_and_icon_image.png?raw=true)
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
        ShadowBuilder,
        ColorBuilder,
        OpacityBuilder {
  final String? image;
  final int type;

  String? _heroTag;

  bool _singleCache = false;

  ImageBuilder hero(String hero) => this.._heroTag = hero;

  ImageBuilder._(this.image, this.type);

  @override
  Widget get mk => createPadding(_buildImage());

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
        borderColor: borderColor.opacity(innerOpacity),
        border: innerBorderWidth,
        heroTag: _heroTag,
        boxShadow: boxShadow,
        useSingleCache: _singleCache,
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
        borderColor: borderColor.opacity(innerOpacity),
        border: innerBorderWidth,
        boxShadow: boxShadow,
        useSingleCache: _singleCache,
      );
    }
    return ImageLoader.image(
      image,
      fit: fit ?? BoxFit.cover,
      width: size ?? width,
      height: size ?? height,
      heroTag: _heroTag,
      borderColor: borderColor.opacity(innerOpacity),
      border: innerBorderWidth,
      boxShadow: boxShadow,
      useSingleCache: _singleCache,
    );
  }

  Widget _buildAssetImage() {
    if (borderColor != null || boxShadow != null) {
      return Container(
        width: size ?? width,
        height: size ?? height,
        decoration: BoxDecoration(
          borderRadius: isCircle ? null : (hasRadius ? borderRadius : BorderRadius.zero),
          border: Border.all(color: borderColor.opacity(innerOpacity)!, width: innerBorderWidth ?? 1.0),
          shape: shape ?? BoxShape.rectangle,
          boxShadow: boxShadow,
          image: image != null
              ? DecorationImage(
                  image: AssetImage(image!),
                  fit: fit ?? BoxFit.cover,
                  colorFilter: innerColor != null ? ColorFilter.mode(innerColor!, BlendMode.srcIn) : null,
                  alignment: alignment ?? Alignment.center,
                )
              : null,
        ),
      );
    }
    if (isCircle) {
      return CircleAvatar(
        backgroundImage: image != null ? AssetImage(image!) : null,
        radius: (size ?? width ?? height ?? 0.0) / 2,
      );
    }
    return Image.asset(
      image ?? '',
      width: size ?? width,
      height: size ?? height,
      alignment: alignment ?? Alignment.center,
      color: innerColor,
    );
  }
}
