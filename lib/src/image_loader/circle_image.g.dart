part of 'image_loader.dart';

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
      debugPrint('you are supported to use ImageLoader.init(ImageLoaderConfig)');
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
            : finalErrorBuilder!(context, url ?? '', Object());
      }
    }
  }
}
