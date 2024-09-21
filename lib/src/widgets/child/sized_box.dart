import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/5
/// describe:

///[SizedBox]
_SizedBoxBuilder get sizedBox => _SizedBoxBuilder._();

class _SizedBoxBuilder extends ChildBuilder<Widget> with SizeBuilder, PaddingBuilder {
  _SizedBoxBuilder._();

  @override
  Widget child(Widget child) {
    return createPadding(
      SizedBox(
        width: size ?? width,
        height: size ?? height,
        child: child,
      ),
    );
  }
}
