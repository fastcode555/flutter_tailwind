import 'package:flutter_tailwind/src/config/image_loader_config.dart';

/// Barry
/// @date 2024/8/21
/// describe:

class Tailwind {
  static Tailwind? _instance;

  factory Tailwind() => _getInstance();

  static Tailwind get instance => _getInstance();

  Tailwind._internal();

  static Tailwind _getInstance() => _instance ??= Tailwind._internal();

  ImageLoaderConfig? imageConfig;

  void addImageConfig(ImageLoaderConfig imageConfig) {
    this.imageConfig = imageConfig;
  }
}
