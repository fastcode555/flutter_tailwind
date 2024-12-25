part of 'image_loader.dart';

class _Image extends StatelessWidget {
  final String? url;
  final PlaceholderWidgetBuilder? placeBuilder;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String? placeHolder;
  final String? errorHolder;
  final String? heroTag;
  final String? thumbUrl;
  final double? border;
  final Color? borderColor;
  final bool transitionOnUserGestures;
  final bool useSingleCache;
  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;
  final double? radius;
  final List<BoxShadow>? boxShadow;

  const _Image(
    this.url, {
    this.placeBuilder,
    this.errorBuilder,
    this.fit,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.width,
    this.height,
    this.border,
    this.borderColor,
    this.useSingleCache = true,
    this.transitionOnUserGestures = false,
    this.thumbUrl,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.radius,
    this.boxShadow,
  });

  bool get _isFile {
    if (kIsWeb) return false;

    var imageFile = File(url ?? '');
    return url != null && url!.isNotEmpty && imageFile.existsSync();
  }

  int? _getMemCacheWidth(double? width) {
    return useSingleCache ? null : (width != null ? (width * _devicePixelRatio!).toInt() : null);
  }

  int? _getMemCacheHeight(double? height) {
    return useSingleCache ? null : (height != null ? (height * _devicePixelRatio!).toInt() : null);
  }

  @override
  Widget build(BuildContext context) {
    _collect(url);
    LoadingErrorWidgetBuilder? finalErrorBuilder;
    PlaceholderWidgetBuilder? finalPlaceBuilder;
    var finalW = width ?? height;
    var finalH = height ?? width; //只要有一个值进来,即便另一个值为空,就默认为正方形图片
    if (ImageLoader.config == null) {
      debugPrint('you are supported to use ImageLoader.init(ImageLoaderConfig)');
    } else {
      finalErrorBuilder =
          errorBuilder ?? ImageLoader.config?.getErrorBuilder(finalW, finalH, border, borderColor, radius);
      finalPlaceBuilder =
          placeBuilder ?? ImageLoader.config?.getPlaceBuilder(finalW, finalH, border, borderColor, radius);
    }
    if (_isNetUrl(url)) {
      return CachedNetworkImage(
        imageUrl: url!,
        key: ValueKey(url),
        fit: fit,
        fadeOutDuration: fadeOutDuration ?? Duration(milliseconds: thumbUrl != null && thumbUrl!.isNotEmpty ? 0 : 1000),
        fadeInDuration: fadeInDuration ?? Duration(milliseconds: thumbUrl != null && thumbUrl!.isNotEmpty ? 0 : 500),
        width: finalW,
        height: finalH,
        memCacheWidth: _getMemCacheWidth(finalW),
        memCacheHeight: _getMemCacheHeight(finalH),
        imageBuilder: (context, imageProvider) {
          if ((borderColor != null && border != null && border! > 0) || boxShadow != null) {
            return _buildHeroWidget(
              heroTag,
              child: Container(
                decoration: BoxDecoration(
                  border: borderColor != null ? Border.all(color: borderColor!, width: border ?? 1.0) : null,
                  borderRadius: BorderRadius.circular(radius ?? 0.0),
                  image: DecorationImage(image: imageProvider, fit: fit),
                  boxShadow: boxShadow,
                ),
              ),
            );
          }
          return _buildBorderCircleImage(
            border,
            borderColor,
            _buildHeroWidget(
              heroTag,
              transitionOnUserGestures: transitionOnUserGestures,
              child: Image(
                image: imageProvider,
                fit: fit,
                width: finalW,
                height: finalH,
              ),
            ),
            shape: BoxShape.rectangle,
            radius: radius,
            boxShadow: boxShadow,
          );
        },
        placeholder: _buildPlaceWidgetBuilder(context, url, finalW, finalH, finalPlaceBuilder, radius),
        errorWidget: (_, __, ___) {
          //有设置了thumbUrl,优先加载小图
          if (thumbUrl != null && thumbUrl!.isNotEmpty) {
            return _buildThumbUrlWidget();
          }
          //有设置方法型,优先加载errorHolder,
          if (errorHolder != null) {
            return _buildBorderCircleImage(
              border,
              borderColor,
              _buildHeroWidget(
                heroTag,
                transitionOnUserGestures: transitionOnUserGestures,
                child: _buildErrorImage(url, width, height),
              ),
              radius: radius,
              shape: BoxShape.rectangle,
              boxShadow: boxShadow,
            );
          }
          if (url?.startsWith('http') ?? false) {
            return _buildBorderCircleImage(
              border,
              borderColor,
              _buildHeroWidget(
                heroTag,
                transitionOnUserGestures: transitionOnUserGestures,
                child: Image.network(
                  url ?? '',
                  errorBuilder: (context, error, StackTrace? stackTrace) {
                    return errorBuilder?.call(context, url ?? '', error) ?? gapEmpty;
                  },
                ),
              ),
              radius: radius,
              shape: BoxShape.rectangle,
              boxShadow: boxShadow,
            );
          }

          //没有使用默认的
          return errorBuilder?.call(context, url ?? '', Object()) ?? gapEmpty;
        },
      );
    }

    return _loadFileOrAssertImage(finalErrorBuilder, finalW, finalH, context);
  }

  //加载文件型图片
  Widget _loadFileOrAssertImage(
      LoadingErrorWidgetBuilder? errorBuilder, double? width, double? height, BuildContext context) {
    if (url._isBase64) {
      return _buildBorderCircleImage(
        border,
        borderColor,
        _buildHeroWidget(
          heroTag,
          transitionOnUserGestures: transitionOnUserGestures,
          child: Image.memory(
            url._base64Body,
            fit: fit,
            width: width,
            height: height,
          ),
        ),
        boxShadow: boxShadow,
        shape: BoxShape.rectangle,
        radius: radius,
      );
    }

    //if the url is File will load with file
    if (_isFile) {
      return _buildBorderCircleImage(
        border,
        borderColor,
        _buildHeroWidget(heroTag,
            transitionOnUserGestures: transitionOnUserGestures,
            child: Image.file(
              File(url!),
              fit: fit,
              cacheWidth: width != null ? (width * _devicePixelRatio!).toInt() : null,
              //cacheHeight: height != null ? (height * _devicePixelRatio!).toInt() : null,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return errorBuilder != null
                    ? errorBuilder(context, url ?? '', error)
                    : _buildHeroWidget(
                        heroTag,
                        transitionOnUserGestures: transitionOnUserGestures,
                        child: Image.asset(errorHolder ?? '', width: width, height: height, fit: fit),
                      );
              },
              width: width,
              height: height ?? width,
            )),
        boxShadow: boxShadow,
        shape: BoxShape.rectangle,
        radius: radius,
      );
    }

    return _buildBorderCircleImage(
      border,
      borderColor,
      _buildHeroWidget(
        heroTag,
        transitionOnUserGestures: transitionOnUserGestures,
        child: Image.asset(
          url != null && url!.isNotEmpty ? url! : errorHolder ?? '',
          width: width,
          height: height,
          fit: fit,
          cacheWidth: width != null ? (width * _devicePixelRatio!).toInt() : null,
          cacheHeight: height != null ? (height * _devicePixelRatio!).toInt() : null,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorHolder != null
                ? Image.asset(errorHolder ?? '', width: width, height: height, fit: fit)
                : (errorBuilder != null ? errorBuilder(context, url ?? '', error) : const SizedBox());
          },
        ),
      ),
      boxShadow: boxShadow,
      shape: BoxShape.rectangle,
      radius: radius,
    );
  }

  PlaceholderWidgetBuilder? _buildPlaceWidgetBuilder(
    BuildContext context,
    String? url,
    double? width,
    double? height,
    PlaceholderWidgetBuilder? placeBuilder,
    double? radius,
  ) {
    //修改,使用者单独传了一个默认图片,单方法配置,优先于全配置,便于定制化,比如默认店铺默认一张默认店铺的图片,商品默认一张商品的图片
    //有设置了thumbUrl,优先加载小图
    if (thumbUrl != null && thumbUrl!.isNotEmpty) {
      return (context, url) => _buildThumbUrlWidget();
    }
    //有设置方法型,优先加载placeHolder,
    if (placeHolder != null) {
      return (context, url) => _buildBorderCircleImage(
            border,
            borderColor,
            _buildHeroWidget(
              heroTag,
              transitionOnUserGestures: transitionOnUserGestures,
              child: Image.asset(
                placeHolder ?? '',
                width: width,
                height: height,
                fit: fit,
                cacheWidth: width != null ? (width * _devicePixelRatio!).toInt() : null,
                cacheHeight: height != null ? (height * _devicePixelRatio!).toInt() : null,
              ),
            ),
            radius: radius,
            shape: BoxShape.rectangle,
            boxShadow: boxShadow,
          );
    }
    //没有使用默认的
    return placeBuilder;
  }

  Widget _buildThumbUrlWidget() {
    return _Image(
      thumbUrl ?? '',
      fit: fit,
      width: width,
      height: height,
      errorBuilder: errorBuilder,
      placeBuilder: placeBuilder,
      placeHolder: placeHolder,
      border: border,
      borderColor: borderColor,
      errorHolder: errorHolder,
      radius: radius,
      boxShadow: boxShadow,
    );
  }

  Widget _buildErrorImage(String? url, double? width, double? height) {
    if (url?.startsWith('http') ?? false) {
      return Image.network(
        url ?? '',
        errorBuilder: (_, __, ___) {
          return Image.asset(
            errorHolder ?? '',
            width: width,
            height: height,
            fit: fit,
            cacheWidth: width != null ? (width * _devicePixelRatio!).toInt() : null,
            cacheHeight: height != null ? (height * _devicePixelRatio!).toInt() : null,
          );
        },
      );
    }
    return Image.asset(
      errorHolder ?? '',
      width: width,
      height: height,
      fit: fit,
      cacheWidth: width != null ? (width * _devicePixelRatio!).toInt() : null,
      cacheHeight: height != null ? (height * _devicePixelRatio!).toInt() : null,
    );
  }
}
