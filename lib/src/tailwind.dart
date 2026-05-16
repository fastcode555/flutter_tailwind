import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/adapters/size_adapter.dart';
import 'package:flutter_tailwind/src/image_loader/base_image_factory.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader_config.dart';

/// Singleton holding library-wide configuration.
///
/// Configurable:
///   - [sizeAdapter] — install via [configSizeAdapter] to enable
///     screen-scaling. Defaults to [IdentitySizeAdapter] (no scaling).
///   - [primaryColor] — read from [init]'s context or set directly.
///   - [imageFactory] / image loader — see [configImageFactory].
///
/// Cached by [init]:
///   - [screenW], [screenH] — populated from MediaQuery at init time.
///     Used by the hFull/wFull/sScreen/sFull-family getters.
///
/// Important: [init] requires a BuildContext that is inside the
/// MaterialApp widget tree. The context is NOT retained — values are
/// extracted immediately and cached to fields.
class Tailwind {
  static Tailwind? _instance;

  factory Tailwind() => _getInstance();

  static Tailwind get instance => _getInstance();

  Tailwind._internal();

  static Tailwind _getInstance() => _instance ??= Tailwind._internal();

  /// The active size adapter. Defaults to identity (no scaling).
  /// Replace via [configSizeAdapter].
  SizeAdapter sizeAdapter = const IdentitySizeAdapter();

  /// Cached screen width in logical pixels. Populated by [init].
  /// Returns 0.0 if [init] hasn't been called yet.
  double screenW = 0.0;

  /// Cached screen height in logical pixels. Populated by [init].
  /// Returns 0.0 if [init] hasn't been called yet.
  double screenH = 0.0;

  Color? primaryColor;

  BaseImageFactory? imageFactory;

  /// Returns the active primary color.
  /// Resolution: [primaryColor] (populated by [init] or set directly) ??
  /// [Colors.amber].
  Color get primary => primaryColor ?? Colors.amber;

  /// One-shot setup. Pulls needed values out of [context] *immediately*
  /// and caches them; does NOT retain the context reference.
  ///
  /// Must be called with a context inside the MaterialApp widget tree
  /// (typically `MaterialApp.builder` or the home page's `build`).
  /// If called from above MaterialApp (e.g. `ScreenUtilInit.builder`),
  /// MediaQuery lookup returns null and screenW/screenH stay 0.
  void init(BuildContext context, [Color? fallbackPrimary]) {
    final mq = MediaQuery.maybeOf(context);
    if (mq != null) {
      screenW = mq.size.width;
      screenH = mq.size.height;
    }
    primaryColor = fallbackPrimary ?? Theme.of(context).primaryColor;
    // context intentionally NOT stored
  }

  /// Install a custom size adapter. Typical call site: app startup.
  void configSizeAdapter(SizeAdapter adapter) {
    sizeAdapter = adapter;
  }

  void addImageConfig(ImageLoaderConfigInterface imageConfig) {
    ImageLoader.init(imageConfig);
  }

  void configImageFactory(BaseImageFactory imageFactory) {
    this.imageFactory = imageFactory;
  }
}
