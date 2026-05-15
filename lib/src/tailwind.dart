import 'package:flutter/material.dart';
import 'package:flutter_tailwind/src/image_loader/base_image_factory.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader.dart';
import 'package:flutter_tailwind/src/image_loader/image_loader_config.dart';

/// Barry
/// @date 2024/8/21
/// describe:

class Tailwind {
  static Tailwind? _instance;

  factory Tailwind() => _getInstance();

  static Tailwind get instance => _getInstance();

  Tailwind._internal();

  static Tailwind _getInstance() => _instance ??= Tailwind._internal();

  BuildContext? context;

  /// Returns the active primary color.
  ///
  /// Resolution order:
  ///   1. If [context] was set via [init], try `Theme.of(context).primaryColor`
  ///   2. If that fails (e.g. the context's widget was deactivated after a
  ///      route change, raising "Looking up a deactivated widget's ancestor
  ///      is unsafe"), fall back to [primaryColor] ?? [Colors.amber]
  ///   3. If [context] is null, fall back to [primaryColor] ?? [Colors.amber]
  ///
  /// **Important:** the [context] passed to [init] must be inside the
  /// `MaterialApp` widget tree. If you call `init` in `ScreenUtilInit.builder`
  /// (above `MaterialApp`), `Theme.of` will silently return
  /// `ThemeData.fallback()` — the user's `MaterialApp.theme` won't apply.
  /// See the analysis doc 3.5 for details.
  Color get primary {
    final ctx = context;
    if (ctx == null) {
      return primaryColor ?? Colors.amber;
    }
    try {
      return Theme.of(ctx).primaryColor;
    } catch (_) {
      // ctx has been deactivated (e.g. the holding widget was disposed).
      // Fall back rather than crashing user code.
      return primaryColor ?? Colors.amber;
    }
  }

  Color? primaryColor;

  BaseImageFactory? imageFactory;

  void init(BuildContext context, [Color? primary]) {
    this.context = context;
    this.primaryColor = primary;
  }

  void addImageConfig(ImageLoaderConfigInterface imageConfig) {
    ImageLoader.init(imageConfig);
  }

  void configImageFactory(BaseImageFactory imageFactory) {
    this.imageFactory = imageFactory;
  }
}
