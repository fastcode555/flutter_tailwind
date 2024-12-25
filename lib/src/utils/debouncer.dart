import 'package:flutter/cupertino.dart';

/// @date 2024/2/19
/// describe:

class Debouncer {
  static Debouncer? _instance;

  static Debouncer get instance => _getInstance();

  Debouncer._internal();

  static Debouncer _getInstance() => _instance ??= Debouncer._internal();

  int _lastTime = 0;

  ///to avoid people crazy click button
  void doubleClickCheck(VoidCallback? onTap, [int interval = 500]) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (_instance!._lastTime != 0 && now - _instance!._lastTime < interval) {
      debugPrint('You click so fast,been blocked $interval');
      return;
    }
    onTap?.call();
    _instance!._lastTime = DateTime.now().millisecondsSinceEpoch;
  }
}
