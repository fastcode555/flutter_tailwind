import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/adapters/size_adapter.dart';

/// Barry
/// @date 2024/9/5
/// describe:

///[SizedBox]
_SizedBoxBuilder get sizedBox => _SizedBoxBuilder._();

class _SizedBoxBuilder extends ChildMkBuilder<Widget> with SizeBuilder, PaddingBuilder {
  _SizedBoxBuilder._();

  @override
  Widget child(Widget child) {
    return createPadding(
      SizedBox(
        width: size != null ? sr(size!) : (width != null ? sw(width!) : null),
        height: size != null ? sr(size!) : (height != null ? sh(height!) : null),
        child: child,
      ),
    );
  }

  @override
  Widget get mk => createPadding(
        SizedBox(
          width: size != null ? sr(size!) : (width != null ? sw(width!) : null),
          height: size != null ? sr(size!) : (height != null ? sh(height!) : null),
        ),
      );
}
