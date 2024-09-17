import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/title_model_builder.dart';

/// Barry
/// @date 2024/9/17
/// describe:

_ShaderMaskBuilder get shaderMask => _ShaderMaskBuilder();

_LinearGradientBuilder get linearGradient => _LinearGradientBuilder();

class _ShaderMaskBuilder extends ChildBuilder<Widget> with ColorBuilder, AlignmentBuilder, TitleModelBuilder {
  @override
  Widget child(Widget child) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: alignments._get(0) ?? alignment ?? Alignment.centerLeft,
          end: alignments._get(1) ?? Alignment.centerRight,
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
        begin: alignments._get(0) ?? alignment ?? Alignment.centerLeft,
        end: alignments._get(1) ?? Alignment.centerRight,
        tileMode: tileMode ?? TileMode.clamp,
        // transform:,
        colors: innerColors ?? [],
      );
}

extension _ListExt on List<Alignment>? {
  Alignment? _get(int index) {
    if (this == null || this!.isEmpty) return null;
    if (index < this!.length) {
      return this![index];
    }
    return null;
  }
}
