import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/5
/// describe:

///[SizedBox]
SizedBoxBuilder get sizedBox => SizedBoxBuilder._();

class SizedBoxBuilder extends ChildBuilder<Widget> with SizeBuilder {
  SizedBoxBuilder._();

  @override
  Widget child(Widget child) {
    return SizedBox(
      width: size ?? width,
      height: size ?? height,
      child: child,
    );
  }
}
