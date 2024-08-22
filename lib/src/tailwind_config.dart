/// Barry
/// @date 2024/8/21
/// describe:

class TailwindConfig {
  static TailwindConfig? _instance;

  factory TailwindConfig() => _getInstance();

  static TailwindConfig get instance => _getInstance();

  TailwindConfig._internal();

  static TailwindConfig _getInstance() => _instance ??= TailwindConfig._internal();

  void addImageConfig() {}
}
