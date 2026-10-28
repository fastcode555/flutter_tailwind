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

  PlaceholderWidgetBuilder? _placeBuilder;

  LoadingErrorWidgetBuilder? _errorBuilder;

  ImageBuilder hero(String hero) => this.._heroTag = hero;

  /// What a network image shows while it loads, in place of
  /// [ImageLoader.config]'s shimmer.
  /// - 'url'.image.s36.circle.placeBuilder((_, __) => fallbackFlag).mk
  ImageBuilder placeBuilder(PlaceholderWidgetBuilder builder) =>
      this.._placeBuilder = builder;

  /// What it shows when it cannot be loaded: a network image that fails, a
  /// file or an asset that is not there. Not used by [asset].
  /// - 'url'.image.rounded10.cover.errorBuilder((_, __, ___) => brokenIcon).mk
  ImageBuilder errorBuilder(LoadingErrorWidgetBuilder builder) =>
      this.._errorBuilder = builder;

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

    final imageFactor = Tailwind.instance.imageFactory;
    // A [BaseImageFactory] takes no builders, so an image that sets one is
    // loaded by [ImageLoader] instead.
    final useImageFactory = imageFactor != null &&
        (image?.startsWith('http') ?? false) &&
        _placeBuilder == null &&
        _errorBuilder == null;
    if (isCircle) {
      final circleRadius = sr(size ?? 0) / 2;
      if (useImageFactory) {
        return imageFactor.loadCircleImage(
          image,
          fit: innerFit ?? BoxFit.cover,
          radius: circleRadius,
          borderColor: borderColor.opacity(innerOpacity),
          border: innerBorderWidth,
          heroTag: _heroTag,
          boxShadow: adaptedBoxShadow,
        );
      }

      return ImageLoader.circle(
        image,
        fit: innerFit ?? BoxFit.cover,
        radius: circleRadius,
        borderColor: borderColor.opacity(innerOpacity),
        border: innerBorderWidth,
        heroTag: _heroTag,
        boxShadow: adaptedBoxShadow,
        useSingleCache: _singleCache,
        placeBuilder: _placeBuilder,
        errorBuilder: _errorBuilder,
      );
    }
    final adaptedWidth =
        size != null ? sr(size!) : (width != null ? sw(width!) : null);
    final adaptedHeight =
        size != null ? sr(size!) : (height != null ? sh(height!) : null);
    if (hasRadius) {
      if (useImageFactory) {
        return imageFactor.loadRound(
          image,
          fit: innerFit ?? BoxFit.cover,
          radius: radius,
          borderRadius:
              radius != null ? null : (hasRadius ? borderRadius : null),
          width: adaptedWidth,
          height: adaptedHeight,
          heroTag: _heroTag,
          borderColor: borderColor.opacity(innerOpacity),
          border: innerBorderWidth,
          boxShadow: adaptedBoxShadow,
        );
      }

      return ImageLoader.round(
        image,
        fit: innerFit ?? BoxFit.cover,
        radius: radius,
        borderRadius: radius != null ? null : (hasRadius ? borderRadius : null),
        width: adaptedWidth,
        height: adaptedHeight,
        heroTag: _heroTag,
        borderColor: borderColor.opacity(innerOpacity),
        border: innerBorderWidth,
        boxShadow: adaptedBoxShadow,
        useSingleCache: _singleCache,
        placeBuilder: _placeBuilder,
        errorBuilder: _errorBuilder,
      );
    }
    if (useImageFactory) {
      return imageFactor.loadImage(
        image,
        fit: innerFit ?? BoxFit.cover,
        width: adaptedWidth,
        height: adaptedHeight,
        heroTag: _heroTag,
        borderColor: borderColor.opacity(innerOpacity),
        border: innerBorderWidth,
        boxShadow: adaptedBoxShadow,
      );
    }
    return ImageLoader.image(
      image,
      fit: innerFit ?? BoxFit.cover,
      width: adaptedWidth,
      height: adaptedHeight,
      heroTag: _heroTag,
      borderColor: borderColor.opacity(innerOpacity),
      border: innerBorderWidth,
      boxShadow: adaptedBoxShadow,
      useSingleCache: _singleCache,
      placeBuilder: _placeBuilder,
      errorBuilder: _errorBuilder,
    );
  }

  Widget _buildAssetImage() {
    if (borderColor != null || boxShadow != null) {
      final adaptedWidth =
          size != null ? sr(size!) : (width != null ? sw(width!) : null);
      final adaptedHeight =
          size != null ? sr(size!) : (height != null ? sh(height!) : null);
      return Container(
        width: adaptedWidth,
        height: adaptedHeight,
        decoration: BoxDecoration(
          borderRadius:
              isCircle ? null : (hasRadius ? borderRadius : BorderRadius.zero),
          border: Border.all(
              color: borderColor.opacity(innerOpacity)!,
              width: innerBorderWidth ?? 1.0),
          shape: innerShape ?? BoxShape.rectangle,
          boxShadow: adaptedBoxShadow,
          image: image != null
              ? DecorationImage(
                  image: AssetImage(image!),
                  fit: innerFit ?? BoxFit.cover,
                  colorFilter: innerColor != null
                      ? ColorFilter.mode(innerColor!, BlendMode.srcIn)
                      : null,
                  alignment: alignment ?? Alignment.center,
                )
              : null,
        ),
      );
    }
    if (isCircle) {
      return CircleAvatar(
        backgroundImage: image != null ? AssetImage(image!) : null,
        radius: sr(size ?? width ?? height ?? 0.0) / 2,
      );
    }
    return Image.asset(
      image ?? '',
      width: size != null ? sr(size!) : (width != null ? sw(width!) : null),
      height: size != null ? sr(size!) : (height != null ? sh(height!) : null),
      fit: innerFit,
      alignment: alignment ?? Alignment.center,
      color: innerColor,
    );
  }
}
