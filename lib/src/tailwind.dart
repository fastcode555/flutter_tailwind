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

  Color get primary => context != null ? Theme.of(context!).primaryColor : primaryColor ?? Colors.amber;

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
