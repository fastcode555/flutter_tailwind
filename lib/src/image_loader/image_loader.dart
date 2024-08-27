import 'dart:io' show File;
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader_config.dart';
import 'package:flutter_tailwind/tailwind.dart';

bool _isNetUrl(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  return url.startsWith('http') && !url.endsWith(".mp3") && !url.endsWith(".mp4");
}

//由于tag只能有一个直接子View
_buildHeroWidget(String? heroTag, {required Widget child, bool? transitionOnUserGestures = false}) {
  if (heroTag == null || heroTag.isEmpty) {
    return child;
  }
  return Hero(
    tag: heroTag,
    transitionOnUserGestures: transitionOnUserGestures ?? false,
    child: child,
  );
}

Widget _buildBorderCircleImage(
  double? border,
  Color? borderColor,
  Widget child, {
  BoxShape shape = BoxShape.circle,
  double? radius,
  List<BoxShadow>? boxShadow,
}) {
  if ((borderColor != null && border != null && border > 0) || boxShadow != null) {
    return Container(
      decoration: BoxDecoration(
        shape: shape,
        border: borderColor != null ? Border.all(color: borderColor, width: border ?? 1.0) : null,
        boxShadow: boxShadow,
        borderRadius: (shape == BoxShape.circle || radius == null) ? null : BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
  if (shape != BoxShape.circle && radius != null) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
  }
  return child;
}

//收集url
void _collect(String? url) {
  if (kReleaseMode) {
    return;
  }
  _imageUrls ??= [];
  if (!_imageUrls!.contains(url) && !(url == null || url.trim().isEmpty)) {
    _imageUrls!.add(url);
  }
}

//作为收集urls的临时存储,release不起作用,主要用于新需求编写测试代码使用
List<String>? _imageUrls;

double? _devicePixelRatio;

class ImageLoader extends StatelessWidget {
  //随机获取一个图片的url
  static String getImage() {
    if (_imageUrls != null && _imageUrls!.isNotEmpty) {
      return _imageUrls![Random().nextInt(_imageUrls!.length)];
    }
    return '';
  }

  static Future<File?> getFromCache(String url) async {
    FileInfo? file = await DefaultCacheManager().getFileFromCache(url);
    return file?.file;
  }

  //随机生成对应数量的urls图片
  static List<String> getImages({int count = 5}) {
    List<String> urls = [];
    if (_imageUrls != null) {
      for (int i = 0; i < count; i++) {
        if (_imageUrls!.isEmpty) {
          urls.add('');
        } else if (_imageUrls!.length == 1) {
          urls.add(_imageUrls![0]);
        } else {
          urls.add(_imageUrls![Random().nextInt(_imageUrls!.length - 1)]);
        }
      }
    }
    return urls;
  }

  static ImageProvider? getImageProvider(String? url) {
    if (_isNetUrl(url)) {
      return CachedNetworkImageProvider(url!);
    } else {
      File imageFile = File(url ?? '');
      bool isFile = url != null && url.isNotEmpty && imageFile.existsSync();
      if (isFile) {
        return FileImage(imageFile);
      }
    }
    return null;
  }

  final String? url;
  final PlaceholderWidgetBuilder? placeBuilder;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final BoxFit fit;
  final String? placeHolder;
  final String? errorHolder;

  final String? heroTag;

  //手指滑动关闭页面时,是否也启用共享元素动画
  final bool transitionOnUserGestures;
  Color? _blurColor;

  double? _width;
  double? _height;
  double? _radius;
  double? _sigmaX;
  double? _sigmaY;
  double? border;
  Color? borderColor;
  BorderRadiusGeometry? _borderRadius;
  String? _thumbUrl;
  final Decoration? decoration;

  static ImageLoaderConfigInterface? config;

  ///according the widget size load the image size，but sometime，some animation have problems，so cannot use diffrents size
  final bool useSingleCache;

  //普通图片
  static const int typeNormal = 0;

  //圆形图片
  static const int typeCircle = 1;

  //圆角图片
  static const int typeRoundCorner = 2;

  //高斯模糊图片
  static const int typeBlur = 3;

  int _type = typeNormal;

  //使用滚动组件NotificationListener包裹住滚动的view，如果滚动停止，就进行加载
  final Type? notification;

  final Duration? fadeOutDuration;
  final Duration? fadeInDuration;

  bool get _canLoadImage => notification == null || notification == ScrollEndNotification;

  final List<BoxShadow>? boxShadow;

  //普通图片
  ImageLoader.image(
    this.url, {
    super.key,
    this.placeBuilder,
    this.errorBuilder,
    this.fit = BoxFit.cover,
    double? width,
    double? height,
    String? thumbUrl,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.transitionOnUserGestures = false,
    this.decoration,
    this.border,
    this.borderColor,
    this.notification,
    this.useSingleCache = false,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.boxShadow,
  }) {
    _width = width;
    _height = height;
    _type = typeNormal;
    _thumbUrl = thumbUrl;
  }

  //圆形图片
  ImageLoader.circle(
    this.url, {
    super.key,
    this.placeBuilder,
    this.errorBuilder,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.fit = BoxFit.cover,
    double? radius,
    this.border = 0.0,
    this.borderColor,
    this.transitionOnUserGestures = false,
    this.decoration,
    this.notification,
    this.useSingleCache = false,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.boxShadow,
  }) {
    _radius = radius;
    _type = typeCircle;
  }

  //圆角图片
  ImageLoader.round(
    this.url, {
    super.key,
    this.placeBuilder,
    this.errorBuilder,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.fit = BoxFit.cover,
    double? width,
    double? height,
    double? radius = 0,
    String? thumbUrl,
    BorderRadius? borderRadius,
    this.border = 0.0,
    this.borderColor = Colors.white,
    this.transitionOnUserGestures = false,
    this.decoration,
    this.notification,
    this.useSingleCache = false,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.boxShadow,
  }) {
    _radius = radius;
    _type = typeRoundCorner;
    _borderRadius = borderRadius;
    _width = width;
    _height = height;
    _thumbUrl = thumbUrl;
  }

  //高斯模糊图片
  ImageLoader.blur(
    this.url, {
    super.key,
    this.placeBuilder,
    this.errorBuilder,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.fit = BoxFit.cover,
    double width = double.infinity,
    double height = double.infinity,
    double sigmaX = 8,
    double sigmaY = 8,
    double radius = 0,
    BorderRadius? borderRadius,
    this.transitionOnUserGestures = false,
    Color? blurColor,
    this.decoration,
    this.notification,
    this.useSingleCache = false,
    this.fadeOutDuration,
    this.fadeInDuration,
    this.boxShadow,
  }) {
    _radius = radius;
    _type = typeBlur;
    _borderRadius = borderRadius ?? const BorderRadius.all(Radius.circular(0));
    _width = width;
    _height = height;
    _sigmaX = sigmaX;
    _sigmaY = sigmaY;
    _blurColor = blurColor;
  }

  static init(ImageLoaderConfigInterface config) {
    ImageLoader.config = config;
  }

  @override
  Widget build(BuildContext context) {
    _devicePixelRatio = _devicePixelRatio ?? ScreenUtil().pixelRatio;
    if (_radius == null && decoration != null && decoration is BoxDecoration) {
      BoxDecoration boxDecoration = decoration as BoxDecoration;
      if (boxDecoration.shape == BoxShape.circle) {
        _type = typeCircle;
        _radius = _radius ?? ((_width ?? _height ?? 0.0) / 2.0);
      } else if (boxDecoration.borderRadius is BorderRadius) {
        _borderRadius = boxDecoration.borderRadius as BorderRadius;
        _type = typeRoundCorner;
      }
    }
    Widget widget = _buildImage(context);
    if (decoration != null) {
      return Container(decoration: decoration, child: widget);
    }
    return widget;
  }

  Widget _buildImage(BuildContext context) {
    //debugPrint("进行图片重新加载${notification},显示图片：${_canLoadImage ? url : null}");
    if (_type == typeNormal) {
      return _Image(
        _canLoadImage ? url : null,
        thumbUrl: _canLoadImage ? _thumbUrl : null,
        placeBuilder: placeBuilder,
        errorBuilder: errorBuilder,
        fit: fit,
        width: _width,
        height: _height,
        borderColor: borderColor,
        border: border,
        placeHolder: placeHolder,
        errorHolder: errorHolder,
        heroTag: heroTag,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        radius: _radius,
        boxShadow: boxShadow,
      );
    } else if (_type == typeCircle) {
      if (_radius == null || _radius == 0) {
        return LayoutBuilder(
          builder: (ctx, constraint) {
            _width = (constraint.maxWidth > constraint.maxHeight ? constraint.maxHeight : constraint.maxWidth);
            return ClipOval(
              child: _Image(
                _canLoadImage ? url : null,
                placeBuilder: placeBuilder,
                errorBuilder: errorBuilder,
                fit: fit,
                width: _width,
                height: _height,
                placeHolder: placeHolder,
                errorHolder: errorHolder,
                borderColor: borderColor,
                border: border,
                useSingleCache: useSingleCache,
                heroTag: heroTag,
                fadeInDuration: fadeInDuration,
                fadeOutDuration: fadeOutDuration,
                radius: _radius,
                boxShadow: boxShadow,
              ),
            );
          },
        );
      }
      return _CircleImage(
        _canLoadImage ? url : null,
        placeHolder: placeHolder,
        errorBuilder: errorBuilder,
        errorHolder: errorHolder,
        fit: fit,
        heroTag: heroTag,
        placeBuilder: placeBuilder,
        radius: _radius,
        border: border,
        useSingleCache: useSingleCache,
        borderColor: borderColor,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        boxShadow: boxShadow,
      );
    } else if (_type == typeRoundCorner) {
      Widget image = _Image(
        _canLoadImage ? url : null,
        fit: fit,
        thumbUrl: _thumbUrl,
        placeHolder: placeHolder,
        errorHolder: errorHolder,
        placeBuilder: placeBuilder,
        errorBuilder: errorBuilder,
        borderColor: borderColor,
        border: border,
        width: _width,
        height: _height,
        useSingleCache: useSingleCache,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: fadeOutDuration,
        radius: _radius,
        heroTag: heroTag,
        boxShadow: boxShadow,
      );
      if (borderColor != null) {
        return image;
      }
      return ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: _borderRadius ?? BorderRadius.all(Radius.circular(_radius!)),
        child: image,
      );
    } else if (_type == typeBlur) {
      return SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: _borderRadius ?? BorderRadius.zero,
              child: _Image(
                _canLoadImage ? url : null,
                fit: fit,
                placeHolder: placeHolder,
                placeBuilder: placeBuilder,
                errorBuilder: errorBuilder,
                heroTag: heroTag,
                errorHolder: errorHolder,
                width: _width,
                border: border,
                borderColor: borderColor,
                fadeOutDuration: fadeOutDuration,
                fadeInDuration: fadeInDuration,
                height: _height,
                radius: _radius,
                boxShadow: boxShadow,
              ),
            ),
            ClipRRect(
              borderRadius: _borderRadius ?? BorderRadius.zero,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX!, sigmaY: _sigmaY!),
                child: Container(color: _blurColor ?? Colors.white10),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}

class _CircleImage extends StatelessWidget {
  final String? url;
  final PlaceholderWidgetBuilder? placeBuilder;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final BoxFit? fit;
  final String? placeHolder;
  final String? errorHolder;
  final String? heroTag;
  final double? radius;
  final double? border;
  final Color? borderColor;
  final bool? transitionOnUserGestures;
  final bool useSingleCache;
  final Duration? fadeInDuration;
  final Duration? fadeOutDuration;
  final List<BoxShadow>? boxShadow;

  const _CircleImage(
    this.url, {
    this.placeBuilder,
    this.errorBuilder,
    this.fit,
    this.placeHolder,
    this.errorHolder,
    this.heroTag,
    this.border = 0,
    this.borderColor = Colors.white,
    this.radius,
    this.useSingleCache = false,
    this.transitionOnUserGestures = false,
    this.fadeInDuration,
    this.fadeOutDuration,
    this.boxShadow,
  });

  int? _getMemCacheWidth() {
    return useSingleCache ? null : ((radius! * _devicePixelRatio!).toInt());
  }

  int? _getMemCacheHeight() {
    return useSingleCache ? null : ((radius! * _devicePixelRatio!).toInt());
  }

  @override
  Widget build(BuildContext context) {
    _collect(url);
    PlaceholderWidgetBuilder? finalPlaceBuilder;
    LoadingErrorWidgetBuilder? finalErrorBuilder;
    if (ImageLoader.config == null) {
      debugPrint("you are supported to use ImageLoader.init(ImageLoaderConfig)");
    } else {
      finalPlaceBuilder = placeBuilder ?? ImageLoader.config?.getCirclePlaceBuilder(radius, border, borderColor);
      finalErrorBuilder = errorBuilder ?? ImageLoader.config?.getCircleErrorBuilder(radius, border, borderColor);
    }

    if (_isNetUrl(url)) {
      return CachedNetworkImage(
        imageUrl: url!,
        memCacheHeight: _getMemCacheWidth(),
        memCacheWidth: _getMemCacheHeight(),
        fadeOutDuration: fadeOutDuration ?? const Duration(milliseconds: 1000),
        fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 500),
        imageBuilder: (context, imageProvider) {
          if ((borderColor != null && border != null && border! > 0) || boxShadow != null) {
            return Container(
              width: radius! * 2,
              height: radius! * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: boxShadow,
                border: borderColor != null ? Border.all(color: borderColor!, width: border ?? 1.0) : null,
                image: DecorationImage(image: imageProvider, fit: fit),
              ),
            );
          }
          return _buildBorderCircleImage(
            border,
            borderColor,
            _buildHeroWidget(
              heroTag,
              transitionOnUserGestures: transitionOnUserGestures,
              child: CircleAvatar(
                backgroundImage: imageProvider,
                radius: radius,
                backgroundColor: Colors.transparent,
              ),
            ),
            boxShadow: boxShadow,
          );
        },
        placeholder: placeHolder != null
            ? (context, url) => _buildBorderCircleImage(
                  border,
                  borderColor,
                  _buildHeroWidget(
                    heroTag,
                    transitionOnUserGestures: transitionOnUserGestures,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(placeHolder ?? ''),
                      radius: radius,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  boxShadow: boxShadow,
                )
            : finalPlaceBuilder,
        errorWidget: errorHolder != null
            ? (context, url, error) => _buildBorderCircleImage(
                  border,
                  borderColor,
                  _buildHeroWidget(
                    heroTag,
                    transitionOnUserGestures: transitionOnUserGestures,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(errorHolder ?? ''),
                      radius: radius,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  boxShadow: boxShadow,
                )
            : finalErrorBuilder,
      );
    } else {
      File imageFile = File(url ?? '');
      bool isFile = url != null && url!.isNotEmpty && imageFile.existsSync();
      if (isFile) {
        return _buildBorderCircleImage(
          border,
          borderColor,
          _buildHeroWidget(
            heroTag,
            transitionOnUserGestures: transitionOnUserGestures,
            child: CircleAvatar(
              radius: radius,
              backgroundImage: FileImage(imageFile),
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      } else {
        return errorHolder != null
            ? _buildBorderCircleImage(
                border,
                borderColor,
                _buildHeroWidget(
                  heroTag,
                  transitionOnUserGestures: transitionOnUserGestures,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(errorHolder ?? ''),
                    radius: radius,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                boxShadow: boxShadow,
              )
            : finalErrorBuilder!(context, url ?? "", Object());
      }
    }
  }
}

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
    double? finalW = width ?? height;
    double? finalH = height ?? width; //只要有一个值进来,即便另一个值为空,就默认为正方形图片
    if (ImageLoader.config == null) {
      debugPrint("you are supported to use ImageLoader.init(ImageLoaderConfig)");
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
                alignment: Alignment.center,
                repeat: ImageRepeat.noRepeat,
                matchTextDirection: false,
                filterQuality: FilterQuality.low,
              ),
            ),
            shape: BoxShape.rectangle,
            radius: radius,
            boxShadow: boxShadow,
          );
        },
        placeholder: _buildPlaceWidgetBuilder(context, url, finalW, finalH, finalPlaceBuilder, radius),
        errorWidget: _buildErrorWidgetBuilder(context, url, finalW, finalH, finalErrorBuilder, radius),
      );
    } else {
      return _loadFileOrAssertImage(finalErrorBuilder, finalW, finalH, context);
    }
  }

  //加载文件型图片
  Widget _loadFileOrAssertImage(
      LoadingErrorWidgetBuilder? errorBuilder, double? width, double? height, BuildContext context) {
    File imageFile = File(url ?? '');
    bool isFile = url != null && url!.isNotEmpty && imageFile.existsSync();
    if (isFile) {
      return _buildBorderCircleImage(
        border,
        borderColor,
        _buildHeroWidget(heroTag,
            transitionOnUserGestures: transitionOnUserGestures,
            child: Image.file(
              imageFile,
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
    } else {
      return errorHolder != null
          ? _buildBorderCircleImage(
              border,
              borderColor,
              _buildHeroWidget(
                heroTag,
                transitionOnUserGestures: transitionOnUserGestures,
                child: Image.asset(
                  url != null && url!.isNotEmpty ? url! : errorHolder!,
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
            )
          : errorBuilder!(context, url ?? '', Object());
    }
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

  LoadingErrorWidgetBuilder? _buildErrorWidgetBuilder(
    BuildContext context,
    String? url,
    double? width,
    double? height,
    LoadingErrorWidgetBuilder? errorBuilder,
    double? radius,
  ) {
    //有设置了thumbUrl,优先加载小图
    if (thumbUrl != null && thumbUrl!.isNotEmpty) {
      return (context, url, error) => _buildThumbUrlWidget();
    }
    //有设置方法型,优先加载errorHolder,
    if (errorHolder != null) {
      return (context, url, error) => _buildBorderCircleImage(
            border,
            borderColor,
            _buildHeroWidget(
              heroTag,
              transitionOnUserGestures: transitionOnUserGestures,
              child: Image.asset(
                errorHolder ?? '',
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
    return errorBuilder;
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
}
