import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_tailwind/src/base/tooltip_builder.dart';
import 'package:flutter_tailwind/src/utils/debouncer.dart';

part 'buttons.p.dart';

/// Barry
/// @date 2024/8/27
/// describe:
class _TextButtonBuilder extends ButtonBuilder {
  _TextButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    late Widget child;
    if (innerChild != null) {
      child = TextButton(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        child: innerChild!,
        style: _buttonStyle,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
      );
    } else {
      child = TextButton.icon(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        icon: _finalIcon,
        style: _buttonStyle,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
        label: Text(super.text, style: style ?? TextStyle(fontSize: fontSize)),
      );
    }

    return createMargin(createExpanded(createSizedBox(child)));
  }

}

class _OutlinedButtonBuilder extends ButtonBuilder {
  _OutlinedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    late Widget child;
    if (innerChild != null) {
      child = OutlinedButton(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        child: innerChild,
        style: _buttonStyle,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
      );
    } else {
      child = OutlinedButton.icon(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        style: _buttonStyle,
        icon: _finalIcon,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
        label: Text(super.text, style: style ?? TextStyle(fontSize: fontSize)),
      );
    }
    return createMargin(createExpanded(createSizedBox(child)));
  }
}

class _ElevatedButtonBuilder extends ButtonBuilder {
  _ElevatedButtonBuilder._(super.text);

  @override
  Widget click({GestureTapCallback? onTap}) {
    late Widget child;
    if (innerChild != null) {
      child = ElevatedButton(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        child: innerChild,
        style: _buttonStyle,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
      );
    } else {
      child = ElevatedButton.icon(
        onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
        style: _buttonStyle,
        icon: _finalIcon,
        iconAlignment: _iconAlignment ?? IconAlignment.start,
        label: Text(super.text, style: style ?? TextStyle(fontSize: fontSize)),
      );
    }
    return createMargin(createExpanded(createSizedBox(child)));
  }
}

class _IconButtonBuilder extends ButtonBuilder with TooltipBuilder {
  _IconButtonBuilder._() : super('');

  @override
  bool get _isIconButton => true;

  @override
  Widget click({GestureTapCallback? onTap}) {
    if (innerChild != null) {
      throw Exception(['IconButton don\'t support method "child()"']);
    }
    return createMargin(IconButton(
      onPressed: () => Debouncer.instance.doubleClickCheck(onTap),
      icon: _finalIcon ?? gapEmpty,
      padding: finalPadding,
      iconSize: size ?? width ?? height,
      tooltip: innerTooltip,
      color: (borderColor ?? innerColor).opacity(innerOpacity),
      style: _buttonStyle,
    ));
  }
}
