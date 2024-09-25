import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/title_model_builder.dart';
import 'package:flutter_tailwind/src/utils/list_ext.dart';

/// Barry
/// @date 2024/9/17
/// describe:

/// # eg:
/// shaderMask.blue.red.orange.centerRight.centerLeft.child(
///  'It is LinearGradient'.text.white.mk,
/// )
_ShaderMaskBuilder get shaderMask => _ShaderMaskBuilder();

_LinearGradientBuilder get linearGradient => _LinearGradientBuilder();

class _ShaderMaskBuilder extends ChildBuilder<Widget> with ColorBuilder, AlignmentBuilder, TitleModelBuilder {
  @override
  Widget child(Widget child) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: alignments.get(0) ?? alignment ?? Alignment.centerLeft,
          end: alignments.get(1) ?? Alignment.centerRight,
          tileMode: tileMode ?? TileMode.clamp,
          // transform:,
          colors: innerColors ?? [],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class _LinearGradientBuilder extends MkBuilder<LinearGradient> with ColorBuilder, AlignmentBuilder, TitleModelBuilder {
  @override
  LinearGradient get mk => LinearGradient(
        begin: alignments.get(0) ?? alignment ?? Alignment.centerLeft,
        end: alignments.get(1) ?? Alignment.centerRight,
        tileMode: tileMode ?? TileMode.clamp,
        // transform:,
        colors: innerColors ?? [],
      );
}
