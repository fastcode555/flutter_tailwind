import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Barry
/// @date 2024/8/23
/// describe:

class ImageLoaderConfig {
  final ImageWidgetBuilder? imageBuilder;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  /// Listener to be called when images fails to load.
  final ValueChanged<Object>? errorListener;

  /// The duration of the fade-in animation for the [placeholder].
  final Duration? placeholderFadeInDuration;

  /// The duration of the fade-out animation for the [placeholder].
  final Duration? fadeOutDuration;

  ImageLoaderConfig({
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.errorListener,
    this.placeholderFadeInDuration,
    this.fadeOutDuration,
  });
}
