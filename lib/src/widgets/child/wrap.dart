import 'package:flutter/cupertino.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/vertical_direction_builder.dart';

/// Barry
/// @date 2024/12/9
/// describe:

mixin WrapMixin {
  WrapAlignment? runAlignment;
  WrapAlignment? alignment;
  WrapCrossAlignment? crossAxisAlignment;
}

extension WrapMixinExt<T extends WrapMixin> on T {
  T get start => this..alignment = WrapAlignment.start;

  T get end => this..alignment = WrapAlignment.end;

  T get center => this..alignment = WrapAlignment.center;

  T get spaceBetween => this..alignment = WrapAlignment.spaceBetween;

  T get spaceAround => this..alignment = WrapAlignment.spaceAround;

  T get spaceEvenly => this..alignment = WrapAlignment.spaceEvenly;

  T get runStart => this..runAlignment = WrapAlignment.start;

  T get runEnd => this..runAlignment = WrapAlignment.end;

  T get runCenter => this..runAlignment = WrapAlignment.center;

  T get runSpaceBetween => this..runAlignment = WrapAlignment.spaceBetween;

  T get runSpaceAround => this..runAlignment = WrapAlignment.spaceAround;

  T get runSpaceEvenly => this..runAlignment = WrapAlignment.spaceEvenly;

  T get crossStart => this..crossAxisAlignment = WrapCrossAlignment.start;

  T get crossEnd => this..crossAxisAlignment = WrapCrossAlignment.end;

  T get crossCenter => this..crossAxisAlignment = WrapCrossAlignment.center;
}

_WrapBuilder get wrap => _WrapBuilder();

class _WrapBuilder extends ChildrenBuilder<Widget>
    with
        SpacingBuilder,
        AxisBuilder,
        TextDirectionBuilder,
        VerticalDirectionBuilder,
        ClipBuilder,
        WrapMixin,
        ExpandedBuilder,
        ColorBuilder,
        PaddingBuilder {
  @override
  Widget children(List<Widget> children) {
    Widget child = Wrap(
      spacing: innerSpacing ?? 0.0,
      runSpacing: innerRunSpacing ?? 0.0,
      runAlignment: runAlignment ?? WrapAlignment.start,
      alignment: alignment ?? WrapAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
      direction: direction ?? Axis.horizontal,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      clipBehavior: clipBehavior ?? Clip.none,
      children: children,
    );
    child = createPadding(child);
    if (innerColor != null) {
      child = DecoratedBox(decoration: BoxDecoration(color: innerColor), child: child);
    }
    return createExpanded(child);
  }
}
