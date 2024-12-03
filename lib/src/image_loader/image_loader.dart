import 'dart:convert';
import 'dart:io' show File;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/image_loader/shimmer_loader_config.dart';

part 'circle_image.g.dart';
part 'image_loader.g.dart';

///data:image/jpeg;base64,
///data:image/png;base64,
///data:image/.*?;base64,
final _base64Header = 'data:image/';
final _base64 = 'base64,';

extension _StringExt on String? {
  bool get _isBase64 {
    if (this == null || this!.isEmpty) return false;
    var value = this!;
    return value.startsWith(_base64Header) && value.contains(_base64);
  }

  Uint8List get _base64Body {
    final index = this!.indexOf(_base64);
    final body = this!.substring(index + _base64.length, this!.length);
    return base64.decode(body);
  }
}

bool _isNetUrl(String? url) {
  if (url == null || url.trim().isEmpty) return false;
  return url.startsWith('http') && !url.endsWith('.mp3') && !url.endsWith('.mp4');
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
    if (shape != BoxShape.circle && radius != null) {
      child = ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
    }
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
    child = ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
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
    var file = await DefaultCacheManager().getFileFromCache(url);
    return file?.file;
  }

  //随机生成对应数量的urls图片
  static List<String> getImages({int count = 5}) {
    var urls = <String>[];
    if (_imageUrls != null) {
      for (var i = 0; i < count; i++) {
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
      var imageFile = File(url ?? '');
      var isFile = url != null && url.isNotEmpty && imageFile.existsSync();
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

  static ImageLoaderConfigInterface? config = ShimmerLoaderConfig();

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
    BorderRadiusGeometry? borderRadius,
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
      var boxDecoration = decoration as BoxDecoration;
      if (boxDecoration.shape == BoxShape.circle) {
        _type = typeCircle;
        _radius = _radius ?? ((_width ?? _height ?? 0.0) / 2.0);
      } else if (boxDecoration.borderRadius is BorderRadius) {
        _borderRadius = boxDecoration.borderRadius as BorderRadius;
        _type = typeRoundCorner;
      }
    }
    var widget = _buildImage(context);
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
        transitionOnUserGestures: transitionOnUserGestures,
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
                transitionOnUserGestures: transitionOnUserGestures,
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
        transitionOnUserGestures: transitionOnUserGestures,
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
        transitionOnUserGestures: transitionOnUserGestures,
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
                transitionOnUserGestures: transitionOnUserGestures,
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
