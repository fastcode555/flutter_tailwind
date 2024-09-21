import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/21
/// describe:

_Padding get padding => _Padding();

class _Padding extends ChildBuilder<Widget> with PaddingBuilder {
  @override
  Widget child(Widget child) => createPadding(child);
}
